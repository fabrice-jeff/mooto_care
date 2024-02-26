import 'dart:convert';

import 'package:get/get.dart';
import '../../../../routes/routes.dart';

import '../../../../utils/share_preference.dart';
import '../../../api.dart';
import '../../../../datas/repository/acteurs.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';

class SecurityController extends GetxController {
  final acteurRepository = ActeurRepository(api: Api.BASE_URL);
  Map<String, dynamic>? statutPaiement;

  //Register
  void register(Map<String, dynamic> data) async {
    final result = await acteurRepository.register(data);

    if (result['success']) {
      Get.offNamed(
        Routes.LOGIN,
      );
    } else {
      print(data);
      Get.offAll(() => RegisterView(errors: result['datas'], oldData: data));
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
    if (result['success']) {
      SharePreferences.prefs.setString('acteur', jsonEncode(result['datas']));
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
}
