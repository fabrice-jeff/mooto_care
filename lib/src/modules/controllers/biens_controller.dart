import 'dart:convert';

import 'package:get/get.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/bien.dart';
import '../../../datas/repository/biens.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';

class BiensController extends GetxController {
  final bienRepository = BienRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();
  List<Bien> biensByActeur = [];
  Bien? bienByNum;

  @override
  void onInit() {
    print(bienByNum);
    allByActeur();
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
    Map<String, dynamic>? response = await bienRepository.add(data);
    if (response!['code'] == Constants.SUCCESS) {
      allByActeur();
      Get.toNamed(Routes.BIENS);
    } else {
      Get.toNamed(Routes.ADD_BIEN);
    }
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
}
