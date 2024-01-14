import 'package:get/get.dart';

import '../src/modules/bindings/base_binding.dart';
import '../src/modules/bindings/biens_binding.dart';
import '../src/modules/bindings/home_binding.dart';
import '../src/modules/screens/add_bien_view.dart';
import '../src/modules/screens/base_view.dart';
import '../src/modules/screens/biens_view.dart';
import '../src/modules/screens/home_view.dart';
import '../src/modules/screens/security/login_view.dart';
import '../src/modules/screens/security/register_view.dart';
import '../src/modules/screens/splash_screen_view.dart';
import 'routes.dart';

class AppPage {
  AppPage._();
  static final INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: Routes.BASE,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreenView(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Routes.BIENS,
      page: () => const BiensView(),
      binding: BiensBinding(),
    ),
    GetPage(
      name: Routes.ADD_BIEN,
      page: () => const AddBienView(),
      binding: BiensBinding(),
    ),
  ];
}
