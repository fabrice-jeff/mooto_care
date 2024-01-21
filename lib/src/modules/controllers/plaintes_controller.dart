import 'package:get/get.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/bien.dart';
import '../../../datas/models/plainte.dart';
import '../../../datas/repository/plaintes.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';

class PlaintesController extends GetxController {
  List<Plainte> plaintesDeposes = [];
  PlainteRepository _plainteRepository = PlainteRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();

  @override
  void onInit() {
    super.onInit();
    getPlaintesDeposes();
  }

  // Ajout d'une demande d'attestation de perte
  addDemandeAttestation(Map<String, dynamic> data) async {
    data['code_acteur'] = acteur!.code;
    var result = await _plainteRepository.addDemandeAttestation(data);
    if (result!['code'] == Constants.SUCCESS) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.DEMANDE_ATTESTATION);
    }
    update();
  }

  // Ajout d'une plainte
  addPlainte(Map<String, dynamic> data) async {
    data['code_acteur'] = acteur!.code;
    var results = await _plainteRepository.addPlainte(data);

    if (results!['code'] == Constants.SUCCESS) {
      getPlaintesDeposes();
      Get.toNamed(Routes.PLAINTES);
    } else {
      Get.toNamed(Routes.ADD_PLAINTE);
    }
    update();
  }

  getPlaintesDeposes() async {
    plaintesDeposes = await _plainteRepository.allPlaintes();
    update();
  }
}
