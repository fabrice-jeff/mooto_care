import 'package:get/get.dart';

import '../controllers/add_bien_controller.dart';

class AddBienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBienController>(() => AddBienController());
  }
}
