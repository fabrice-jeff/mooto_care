import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';
import '../../../datas/repository/acteurs.dart';

class SecurityController extends GetxController {
  final acteurRepository = ActeurRepository(api: Api.BASE_URL);

  //Register
  void register(Map<String, dynamic> data) async {
    final result = await acteurRepository.register(data);
    if (result['code'] == Constants.SUCCESS) {
      Get.offNamed(Routes.LOGIN);
    }
  }

  //Login
  void login(Map<String, dynamic> data) async {
    final result = await acteurRepository.login(data);
    if (result!['code'] == Constants.SUCCESS) {
      SharePreferences.prefs.setString('acteur', result['acteur']);
      Get.offNamed(Routes.BASE);
    }
  }
}
