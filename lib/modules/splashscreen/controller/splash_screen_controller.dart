import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/routes.dart';

class SplashScreenController extends GetxController {
  String? acteur;
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    setActeur();
    if (acteur == null) {
      Get.offNamed(Routes.login);
    } else {
      Get.offNamed(Routes.BASE);
    }
    super.onInit();
  }

  setActeur() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    acteur = prefs.getString('acteur');
  }
}
