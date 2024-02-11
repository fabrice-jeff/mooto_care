import 'dart:convert';

import 'package:get/get.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/bien.dart';
import '../../../datas/models/type_type.dart';
import '../../../datas/repository/biens.dart';
import '../../../routes/routes.dart';
import '../../../services/generate_random_file_name.dart';
import '../../../services/paiement.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';

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
    biensByActeur = await bienRepository.allByActeur(data);
    update();
  }

  // Ajout d'un bien
  add(Map<String, dynamic> data) async {
    var amount = _amountByCouverture(data['couverture'], data['promotion']);
    // Demande de paiement
    var paiement = Paiement(
      amount: amount,
      name: acteur!.nom + " " + acteur!.prenoms,
      email: acteur!.email,
      onStatutPaiementsChanged: handleStatutPaiement,
    );
    await Get.to(paiement.initPaiement());

    if (statutPaiement != null &&
        statutPaiement!['code'] == Constants.SUCCESS) {
      print(statutPaiement);
      // Ajout des informations pour la transactions
      data['amount'] = amount.toString();
      data['transaction_id'] = statutPaiement!['transactionId'];
      // data['transaction_id'] = "kbsdjjks";

      data['promotion'] = data['promotion'].toString();
      data['file'] = base64Encode(data['file'].readAsBytesSync());
      data['filename'] = generateRandomFileName('file');
      Map<String, dynamic>? response = await bienRepository.add(data);
      showPromo(false);
      if (response!['code'] == Constants.SUCCESS) {
        allByActeur();
        Get.toNamed(Routes.BIENS);
      } else {
        Get.toNamed(Routes.ADD_BIEN);
      }
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
    dynamic result = await bienRepository.getByNum(data);

    if (result['code'] == Constants.SUCCESS) {
      bienByNum = Bien.fromJson(jsonDecode(result['bien']));
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
    // TypeType? couvertureObjet;
    // for (var element in typesCouvertures) {
    //   if (element.libelle == couverture) {
    //     couvertureObjet = element;
    //     break;
    //   }
    // }
    // Vérifier le type de couverture
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
}
