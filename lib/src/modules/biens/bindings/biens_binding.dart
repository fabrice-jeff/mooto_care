import 'package:get/get.dart';

import '../controllers/biens_controller.dart';

class BiensBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiensController>(() => BiensController());
  }
}
