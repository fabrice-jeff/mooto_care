import 'dart:convert';

import 'package:autocare/src/modules/biens/views/assure_bien_view.dart';
import 'package:get/get.dart';

import '../../../../datas/models/acteur.dart';
import '../../../../datas/models/bien.dart';
import '../../../../datas/models/type_type.dart';
import '../../../../datas/repository/biens.dart';
import '../../../../routes/routes.dart';
import '../../../../services/generate_random_file_name.dart';
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
      data['filename'] = generateRandomFileName('file');
      data['file'] = base64Encode(data['file'].readAsBytesSync());
    }

    Map<String, dynamic>? result = await bienRepository.add(data);

    if (result != null) {
      if (result['success']) {
        // Succes
        Get.offAllNamed(Routes.BASE);
      } else {
        // Echec

        Get.offAndToNamed(Routes.ADD_BIEN,
            arguments: {'errors': result['datas'], 'oldData': data});
      }
    }
  }

  void handleStatutPaiement(Map<String, dynamic>? selectedValue) {
    statutPaiement = selectedValue;
  }

  // Récupérer un bien par son numero plaque
  getByNum(String numPlaque) async {
    Map<String, dynamic> data = {
      'num_plaque': numPlaque,
    };
    var result = await bienRepository.getByNum(data);
    if (result != null) {
      if (result['success']) {
        var data = result['datas'];
        data['bien']['type_type'] = result['type_type'];
        data['bien']['fichier'] = data['fichier'];
        data["bien"]['acteur'] = data['user'];
        data["bien"]['status'] = data['status'];
        bienByNum = Bien.fromJson(data['bien']);
      } else {
        bienByNum = null;
      }
    }
    update();
  }

  getCouvertures() async {
    // typesCouvertures =

    var result = await bienRepository.getCouvertures();
    if (result != null) {
      for (var couverture in result['datas']) {
        var objet = TypeType.fromJson(couverture);
        typesCouvertures.add(objet);
        couvertures.add(objet.libelle);
      }
      print(typesCouvertures);
      print(couvertures);
    }

    // return couvertures;
    // for (var couverture in typesCouvertures) {
    //   couvertures.add(couverture.libelle);
    // }
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
  assureMoto(Map<String, dynamic> data, Bien moto) async {
    //  'code_bien' => 'required|string',
    // 'transaction_id' => 'required|string',
    // 'amount' => 'required|string',
    // 'couverture' => 'required|string',
    // 'promotion' => 'required|string',
    if (data['couverture'] == null) {
      data['couverture'] = "";
      data['transaction_id'] = "";
      data["amount"] = "";
      data['promotion'] = "";
      data['bien'] = jsonEncode(data['bien']);
    }
    Map<String, dynamic>? result = await bienRepository.assureMoto(
      data,
    );
    print(result);
    if (result != null) {
      if (result['success']) {
        // Succes
        Get.offAllNamed(Routes.BASE);
      } else {
        // Echec
        Get.offAndToNamed(Routes.assureBien, arguments: {
          'bien': moto,
          'errors': result['datas'],
          'oldData': data
        });
      }
    }
  }
}
