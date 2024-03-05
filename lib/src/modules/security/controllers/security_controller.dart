import 'dart:convert';

import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/share_preference.dart';
import '../../../api.dart';
import '../../../../datas/repository/acteurs.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../views/verification_code_view.dart';

class SecurityController extends GetxController {
  final acteurRepository = ActeurRepository(api: Api.BASE_URL);
  Map<String, dynamic>? statutPaiement;

  //Register
  void register(Map<String, dynamic> data) async {
    data["sexe"] = (data['sexe'] == null) ? "" : data['sexe'];
    final result = await acteurRepository.register(data);
    if (result != null) {
      if (result['success']) {
        // Verification de l'email de l'utilisateur

        Get.toNamed(Routes.verificationEmail,
            arguments: {'email': data['email']});
      } else {
        Get.offAll(() => RegisterView(errors: result['datas'], oldData: data));
      }
    }

    // // Demande de paiement
    // int amount = int.parse(data['amount']);
    // if (amount >= 100) {
    //   var paiement = Paiement(
    //     amount: amount,
    //     name: data['name'] + " " + data['prenoms'],
    //     email: data['email'],
    //     onStatutPaiementsChanged: handleStatutPaiement,
    //   );
    //   await Get.to(paiement.initPaiement());
    //   if (statutPaiement != null &&
    //       statutPaiement!['code'] == Constants.SUCCESS) {
    //     print(statutPaiement);
    //     // Ajout des informations pour la transactions
    //     data['amount'] = amount.toString();
    //     data['transaction_id'] = statutPaiement!['transactionId'];
    //     // data['transaction_id'] = "kbsdjjks";

    //     final result = await acteurRepository.register(data);
    //     if (result!['code'] == Constants.SUCCESS) {
    //       Get.offNamed(Routes.LOGIN);
    //     }
    //   }
    // }
  }

  //Login
  void login(Map<String, dynamic> data) async {
    final result = await acteurRepository.login(data);
    print(result);
    if (result['success']) {
      Map<String, dynamic> data = result['datas'];
      data['token'] = result['token'];
      SharePreferences.prefs.setString('acteur', jsonEncode(data));

      Get.offNamed(
        Routes.BASE,
      );
    } else {
      Get.offAll(() => LoginView(errors: result['datas'], oldData: data));
    }
  }

  void handleStatutPaiement(Map<String, dynamic>? selectedValue) {
    statutPaiement = selectedValue;
  }

  void verificationCodeEmail(Map<String, dynamic> data) async {
    print(data);
    final result = await acteurRepository.verificationEmail(data);
    if (result != null) {
      if (result['success']) {
        Get.toNamed(Routes.login);
      } else {
        Get.offAll(
          () => VerificationCodeView(
            errors: result['datas'],
            email: data['email'],
          ),
        );
      }
    }
  }

  void resendValidationMail(Map<String, dynamic> data) async {
    final result = await acteurRepository.resendValidationMail(data);
    print(result);
    // if (result != null) {
    //   if (result['success']) {
    //     Get.toNamed(Routes.login);
    //   } else {
    //     Get.offAll(
    //       () => VerificationCodeView(
    //         errors: result['datas'],
    //         email: data['email'],
    //       ),
    //     );
    //   }
    // }
  }
}
