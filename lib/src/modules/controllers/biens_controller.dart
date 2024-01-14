import 'package:get/get.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/bien.dart';
import '../../../datas/repository/biens.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api/api.dart';

class BiensController extends GetxController {
  final bienRepository = BienRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();
  List<Bien> biens = [];

  @override
  void onInit() {
    all();
    super.onInit();
  }

  // Récupération de tous les biens de l'acteur connecté
  all() async {
    Map<String, dynamic> data = {'code_acteur': acteur!.code};
    biens = await bienRepository.all(data);
    update();
  }

  // Ajout d'un bien
  add(Map<String, dynamic> data) async {
    Map<String, dynamic>? response = await bienRepository.add(data);
    print(response);
    if (response!['code'] == Constants.SUCCESS) {
      all();
      Get.toNamed(Routes.BIENS);
    } else {
      Get.toNamed(Routes.ADD_BIEN);
    }
  }
}
