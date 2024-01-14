import 'package:get/get.dart';

import '../controllers/base_controller.dart';
import '../controllers/biens_controller.dart';
import '../controllers/home_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BiensController>(() => BiensController());
  }
}
