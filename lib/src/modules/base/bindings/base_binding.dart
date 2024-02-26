import 'package:get/get.dart';

import '../../notifications/controllers/notifications_controller.dart';
import '../controllers/base_controller.dart';
import '../../biens/controllers/biens_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../plaintes/controllers/plaintes_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BiensController>(() => BiensController());
    Get.lazyPut<PlaintesController>(() => PlaintesController());
    Get.lazyPut<NotificationsController>(
      () => NotificationsController(),
    );
  }
}
