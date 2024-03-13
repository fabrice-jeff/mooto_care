import 'package:get/get.dart';

import '../modules/base/bindings/base_binding.dart';
import '../modules/biens/bindings/biens_binding.dart';
import '../modules/biens/views/add_bien_view.dart';
import '../modules/biens/views/assure_bien_view.dart';
import '../modules/biens/views/biens_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/plaintes/bindings/plainte_binding.dart';
import '../modules/plaintes/views/add_plainte_view.dart';
import '../modules/plaintes/views/demande_attestation_view.dart';
import '../modules/plaintes/views/home_plainte_view.dart';
import '../modules/plaintes/views/plaintes_view.dart';
import '../modules/security/views/login_view.dart';
import '../modules/security/views/register_view.dart';
import '../modules/security/views/verification_code_view.dart';
import '../modules/views/parametres_view.dart';
import '../modules/base/views/base_view.dart';
import '../modules/home/views/home_view.dart';

import '../modules/views/plus_view.dart';
import '../modules/splashscreen/views/splash_screen_view.dart';
import '../modules/views/tarifs_view.dart';
import '../modules/verifications/verification_view.dart';
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
      name: Routes.register,
      page: () => RegisterView(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Routes.BIENS,
      page: () => const BiensView(),
      binding: BiensBinding(),
    ),
    GetPage(
      name: Routes.ADD_BIEN,
      page: () => AddBienView(),
      binding: BiensBinding(),
    ),
    GetPage(
      name: Routes.verificationMoto,
      page: () => VerificationView(),
      binding: BiensBinding(),
    ),
    GetPage(
      name: Routes.ADD_PLAINTE,
      page: () => AddPlainteView(),
      binding: PlaintesBinding(),
    ),
    GetPage(
      name: Routes.HOME_PLAINTE,
      page: () => const HomePlainteView(),
      binding: PlaintesBinding(),
    ),
    GetPage(
      name: Routes.DEMANDE_ATTESTATION,
      page: () => DemandeAttestationView(),
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
    // Verification code email
    GetPage(
      name: Routes.verificationEmail,
      page: () => VerificationCodeView(),
    ),

    GetPage(
      name: Routes.assureBien,
      page: () => AssureBienView(),
    ),
  ];
}
