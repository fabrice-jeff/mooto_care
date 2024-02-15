import 'dart:convert';

import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/plainte.dart';
import '../../../datas/repository/plaintes.dart';
import '../../../generated_attestation.dart';
import '../../../routes/routes.dart';
import '../../../services/generate_random_file_name.dart';
import '../../../services/paiement.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';

class PlaintesController extends GetxController {
  List<Plainte> plaintesDeposes = [];
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
      data['transaction_id'] = statutPaiement!['transactionId'];
      // data['transaction_id'] = "kbsdjjks";

      // Générer le fichier PDF
      Map<String, dynamic> attestationDemande = {
        'nom': acteur!.nom,
        'prenoms': acteur!.prenoms,
        'date_perte': data['date_perte'],
        'numero_plaque': data['numero_plaque'],
      };
      final pdfData = await generatePDF(attestationDemande);
      String file = base64Encode(pdfData);
      String filename = generateRandomFileName('demande');
      String extension = "pdf";
      data['file'] = file;
      data['filename'] = filename;
      data['extension'] = extension;
      data['date_perte'] = data['date_perte'].toString();

      var result = await _plainteRepository.addDemandeAttestation(data);

      if (result!['code'] == Constants.SUCCESS) {
        // Envoyer un email
        // _sendEmail(
        //   recipient: acteur!.email,
        //   subject: "Paiement",
        //   content: "Votre paiements a été effectué avec succès",
        // );
        Get.toNamed(Routes.BASE);
      } else {
        Get.toNamed(Routes.DEMANDE_ATTESTATION);
      }
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
    plaintesDeposes = await _plainteRepository.allPlaintes();
    update();
  }

  void _sendEmail({
    required String recipient,
    required String subject,
    required String content,
  }) async {
    String username = 'mootocare@gmail.com';
    // String password = 'eetp stzy wrvx yntb';
    String password = 'eetpstzywrvxyntb';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'MootoCare Service')
      ..recipients.add(recipient)
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = subject
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.!'
      ..html = content;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
