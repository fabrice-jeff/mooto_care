import 'dart:convert';

import 'package:get/get.dart';

import '../../../../datas/models/acteur.dart';
import '../../../../datas/models/bien.dart';
import '../../../../datas/models/type_type.dart';
import '../../../../datas/repository/biens.dart';
import '../../../../routes/routes.dart';
import '../../../../services/generate_random_file_name.dart';
import '../../../../services/paiement.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/share_preference.dart';
import '../../../api.dart';

class BiensController extends GetxController {
  final bienRepository = BienRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();
  List<Bien> biensByActeur = [];
  bool showPromotion = false;
  List<TypeType> typesCouvertures = [];
  List<String> couvertures = [];
  Map<String, dynamic>? statutPaiement;

  Bien? bienByNum;

  @override
  void onInit() {
    allByActeur();
    getCouvertures();
    super.onInit();
  }

  // Récupération de tous les biens de l'acteur connecté
  allByActeur() async {
    Map<String, dynamic> data = {'code_acteur': acteur!.code};

    var results = await bienRepository.allByActeur(data);
    if (results != null && results['success']) {
      // Nous allons récupérer l'ensemble des  biens enregistré dans le tableau concerné
      for (var bien in results['datas']) {
        bien['bien']['acteur'] = bien['acteur'];
        bien['bien']['fichier'] = bien['fichier'];
        var typeType = bien['type_type'];
        bien['bien']['type_couverture'] = typeType;
        bien['bien']['status'] = bien['status'];
        biensByActeur.add(Bien.fromJson(bien['bien']));
      }
    } else {
      biensByActeur = [];
    }
    update();
  }

  // Ajout d'un bien
  add(Map<String, dynamic> data) async {
    if (data['file'] == null) {
      data['file'] = "";
      data['extension'] = "";
    } else {
      data['file'] = base64Encode(data['file'].readAsBytesSync());
    }

    data['filename'] = generateRandomFileName('file');

    Map<String, dynamic> result = await bienRepository.add(data);
    // print(result['datas']);
    if (result['success']) {
      // Succes
      Get.offAllNamed(Routes.BASE);
    } else {
      // Echec

      Get.offAndToNamed(Routes.ADD_BIEN,
          arguments: {'errors': result['datas'], 'oldData': data});
    }
  }

  void handleStatutPaiement(Map<String, dynamic>? selectedValue) {
    statutPaiement = selectedValue;
  }

  // Récupérer un bien pat son numero plaque
  getByNum(String numPlaque) async {
    Map<String, dynamic> data = {
      'num_plaque': numPlaque,
    };
    var result = await bienRepository.getByNum(data);
    // print(result);
    if (result['success']) {
      var data = result['datas'];
      print(data['bien']);
      data['bien']['type_couverture'] = result['type_type'];
      data['bien']['fichier'] = data['fichier'];
      data["bien"]['acteur'] = data['acteur'];
      data["bien"]['status'] = data['status'];
      bienByNum = Bien.fromJson(data['bien']);
    } else {
      bienByNum = null;
    }

    update();
  }

  getCouvertures() async {
    typesCouvertures = await bienRepository.getCouvertures();
    for (var couverture in typesCouvertures) {
      couvertures.add(couverture.libelle);
    }
  }

  int _amountByCouverture(String couverture, bool promotion) {
    int amount;
    switch (couverture) {
      case Constants.TYPE_COUVERTURE_BASIQUE:
        amount = 5000;
        if (promotion) {
          amount = 1000;
        }
        break;
      case Constants.TYPE_COUVERTURE_GOLD:
        amount = 25000;
        break;
      case Constants.TYPE_COUVERTURE_VIP:
        amount = 50000;
        break;
      default:
        amount = 2000;
        break;
    }
    return amount;
  }

  showPromo(bool value) {
    showPromotion = value;
    update();
  }

  // Assure une moto
  assureMoto(Map<String, dynamic> data) async {
    // Demande de paiement
    var amount = _amountByCouverture(data['couverture'], data['promotion']);
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
      data['promotion'] = data['promotion'].toString();
      Map<String, dynamic>? response = await bienRepository.assureMoto(data);
      if (response!['code'] == Constants.SUCCESS) {
        allByActeur();
        Get.toNamed(Routes.BIENS);
      } else {
        Get.toNamed(Routes.ADD_BIEN);
      }
    }
  }
}
