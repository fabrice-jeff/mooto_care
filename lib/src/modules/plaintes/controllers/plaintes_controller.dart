import 'dart:convert';
import 'package:get/get.dart';

import '../../../../datas/models/acteur.dart';
import '../../../../datas/models/plainte.dart';
import '../../../../datas/repository/biens.dart';
import '../../../../datas/repository/plaintes.dart';
import '../../../../generated_attestation.dart';
import '../../../../routes/routes.dart';
import '../../../../services/datetime_format.dart';
import '../../../../services/generate_random_file_name.dart';
import '../../../../services/paiement.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/share_preference.dart';
import '../../../api.dart';

class PlaintesController extends GetxController {
  List<Plainte> plaintesDeposes = [];
  BienRepository _bienRepository = BienRepository(api: Api.BASE_URL);
  PlainteRepository _plainteRepository = PlainteRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();
  Map<String, dynamic>? statutPaiement;

  @override
  void onInit() {
    super.onInit();
    getPlaintesDeposes();
  }

  // Ajout d'une demande d'attestation de perte
  addDemandeAttestation(Map<String, dynamic> data) async {
    // Si aucune valeur n'est renseigné dans les champs,  alors on affiche les messages d'erreur
    //Pour cela, nous devons mettre les autres parametres à null
    // Les paramettres dont nous avons besoin pour consormé l'api
    // numero_plaque, file,  extension, filename, transaction_id, amount, date_perte, description,
    if (data['numero_plaque'] == '' ||
        data['date_perte'] == '' ||
        data['description'] == '') {
      data['transaction_id'] = "";
      data['file'] = "";
      data['extension'] = "";
      data["filename"] = "";
    } else {
      // Verifier si le numéro de plaque correspond à un bien
      // Si ca correspond à un bien nous pouvons générer le fichier
      var bienExist =
          await _bienRepository.getByNum({"num_plaque": data['numero_plaque']});
      if (bienExist['success']) {
        // Générer le fichier PDF
        Map<String, dynamic> attestationDemande = {
          'nom': acteur!.nom,
          'prenoms': acteur!.prenoms,
          'date_perte': dateTimeFormat(data['date_perte']),
          'numero_plaque': data['numero_plaque'],
        };
        final pdfData = await generatePDF(attestationDemande);
        String file = base64Encode(pdfData);
        String filename = generateRandomFileName('demande');
        String extension = "pdf";
        data['file'] = file;
        data['filename'] = filename;
        data['extension'] = extension;
        data['date_perte'] = data['date_perte'];

        // Demande de paiement
        int amount = 1000;
        var paiement = Paiement(
          amount: amount,
          name: acteur!.nom + " " + acteur!.prenoms,
          email: acteur!.email,
          onStatutPaiementsChanged: handleStatutPaiement,
        );
        await Get.to(paiement.initPaiement());

        if (statutPaiement != null &&
            statutPaiement!['code'] == Constants.SUCCESS) {
          // Ajout des informations pour la transactions
          data['amount'] = amount.toString();
          data['transaction_id'] = statutPaiement!['transactionId'];
          // data['transaction_id'] = "kbsdjjks";
        } else {
          Get.offAndToNamed(Routes.DEMANDE_ATTESTATION, arguments: {
            'errors': {'paiement': 'Le paiement a échoué. Veuillez réessayeer'},
          });
        }
      } else {
        // Nous devons retourné vers la page avec une erreur.
        Get.offAndToNamed(Routes.DEMANDE_ATTESTATION, arguments: {
          'errors': {
            'not_num_plaque': 'Le numéro de plaque ne correspond à aucune moto'
          },
        });
      }
    }

    var result = await _plainteRepository.addDemandeAttestation(data);
    if (result['success']) {
      Get.offAllNamed(Routes.BASE);
    } else {
      Get.offAndToNamed(Routes.DEMANDE_ATTESTATION,
          arguments: {'errors': result['datas'], 'oldData': data});
    }

    update();
  }

  void handleStatutPaiement(Map<String, dynamic>? selectedValue) {
    statutPaiement = selectedValue;
  }

  // Ajout d'une plainte
  addPlainte(Map<String, dynamic> data) async {
    // Demande de paiement
    int amount = 1000;
    var paiement = Paiement(
      amount: amount,
      name: acteur!.nom + " " + acteur!.prenoms,
      email: acteur!.email,
      onStatutPaiementsChanged: handleStatutPaiement,
    );
    await Get.to(paiement.initPaiement());

    if (statutPaiement != null &&
        statutPaiement!['code'] == Constants.SUCCESS) {
      data['code_acteur'] = acteur!.code;
      // Ajout des informations pour la transactions
      data['amount'] = amount.toString();
      // data['transaction_id'] = statutPaiement!['transactionId'];
      data['transaction_id'] = "kbsdjjks";
      // Informations sur le fichier
      data['attestation'] = base64Encode(data['attestation'].readAsBytesSync());
      data['filename'] = generateRandomFileName('attestation');
      var results = await _plainteRepository.addPlainte(data);

      if (results!['code'] == Constants.SUCCESS) {
        getPlaintesDeposes();
        Get.toNamed(Routes.PLAINTES);
      } else {
        Get.toNamed(Routes.ADD_PLAINTE);
      }
    }

    update();
  }

  getPlaintesDeposes() async {
    var results = await _plainteRepository.allPlaintes();
    if (results != null && results['success']) {
      // Nous allons récupérer l'ensemble des  biens enregistré dans le tableau concerné
      for (var plainte in results['datas']) {
        plainte['bien']['acteur'] = plainte['acteur'];
        plainte['bien']['fichier'] = plainte['fichier'];
        plainte['bien']['type_couverture'] = plainte['type_type'];
        plainte['bien']['status'] = plainte['status'];
        plainte['plainte']['bien'] = plainte['bien'];
        plaintesDeposes.add(Plainte.fromJson(plainte['plainte']));
      }
    } else {
      plaintesDeposes = [];
    }
    update();
  }
}
