import 'package:get/get.dart';

import '../src/modules/bindings/base_binding.dart';
import '../src/modules/bindings/biens_binding.dart';
import '../src/modules/bindings/home_binding.dart';
import '../src/modules/bindings/plainte_binding.dart';
import '../src/modules/views/biens/add_bien_view.dart';
import '../src/modules/views/parametres_view.dart';
import '../src/modules/views/plaintes/add_plainte_view.dart';
import '../src/modules/views/base_view.dart';
import '../src/modules/views/biens/biens_view.dart';
import '../src/modules/views/home_view.dart';
import '../src/modules/views/plaintes/demande_attestation_view.dart';
import '../src/modules/views/plaintes/home_plainte_view.dart';
import '../src/modules/views/plaintes/plaintes_view.dart';
import '../src/modules/views/plus_view.dart';
import '../src/modules/views/security/login_view.dart';
import '../src/modules/views/security/register_view.dart';
import '../src/modules/views/splash_screen_view.dart';
import '../src/modules/views/tarifs_view.dart';
import '../src/modules/views/verifications/verification_view.dart';
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
    GetPage(
      name: Routes.PLUS,
      page: () => const PlusView(),
    ),
    GetPage(
      name: Routes.TARIFS,
      page: () => const TarifsView(),
    ),
    GetPage(
      name: Routes.PARAMETRES,
      page: () => const ParametresView(),
    ),
  ];
}
