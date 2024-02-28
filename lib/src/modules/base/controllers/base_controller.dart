import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../datas/models/acteur.dart';
import '../../../../utils/share_preference.dart';

class BaseController extends GetxController {
  Acteur? acteur = SharePreferences.getActeur();

  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }
}
