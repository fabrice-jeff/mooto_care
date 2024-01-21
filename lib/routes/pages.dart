import 'package:get/get.dart';

import '../src/modules/bindings/base_binding.dart';
import '../src/modules/bindings/biens_binding.dart';
import '../src/modules/bindings/home_binding.dart';
import '../src/modules/bindings/plainte_binding.dart';
import '../src/modules/screens/biens/add_bien_view.dart';
import '../src/modules/screens/plaintes/add_plainte_view.dart';
import '../src/modules/screens/base_view.dart';
import '../src/modules/screens/biens/biens_view.dart';
import '../src/modules/screens/home_view.dart';
import '../src/modules/screens/plaintes/demande_attestation.dart';
import '../src/modules/screens/plaintes/home_plainte_view.dart';
import '../src/modules/screens/plaintes/plaintes_view.dart';
import '../src/modules/screens/security/login_view.dart';
import '../src/modules/screens/security/register_view.dart';
import '../src/modules/screens/splash_screen_view.dart';
import '../src/modules/screens/verification_view.dart';
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
    GetPage(
      name: Routes.VERIFICATION,
      page: () => const VerificationView(),
      binding: BiensBinding(),
    ),
    GetPage(
      name: Routes.ADD_PLAINTE,
      page: () => const AddPlainteView(),
      binding: PlaintesBinding(),
    ),
    GetPage(
      name: Routes.HOME_PLAINTE,
      page: () => const HomePlainteView(),
      binding: PlaintesBinding(),
    ),
    GetPage(
      name: Routes.DEMANDE_ATTESTATION,
      page: () => const DemandeAttestationView(),
      binding: PlaintesBinding(),
    ),
    GetPage(
      name: Routes.PLAINTES,
      page: () => const PlaintesView(),
      binding: PlaintesBinding(),
    ),
  ];
}
