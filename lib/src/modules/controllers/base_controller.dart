import 'package:get/get_state_manager/get_state_manager.dart';

class BaseController extends GetxController {
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }
}
