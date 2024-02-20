import 'package:get/get.dart';

import '../controllers/plaintes_controller.dart';

class PlaintesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaintesController>(() => PlaintesController());
  }
}
