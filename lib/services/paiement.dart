import 'package:get/get.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';

import '../utils/constants.dart';

late String statusPaiement;

class Paiement {
  final int amount;
  final String name;
  final String email;
  final bool sandbox;
  final void Function(Map<String, dynamic>?) onStatutPaiementsChanged;
  const Paiement({
    required this.amount,
    required this.name,
    required this.email,
    this.sandbox = true,
    required this.onStatutPaiementsChanged,
  });

  KKiaPay initPaiement() {
    var kkiapay = KKiaPay(
      amount: amount,
      countries: ["BJ"],
      phone: "22961000000",
      name: name,
      email: email,
      reason: 'transaction reason',
      data: 'Fake data',
      sandbox: sandbox,
      apikey: "f1092c30b88711eea59f2d53a2c58eae",
      callback: _successCallback,
      theme: defaultTheme,
      partnerId: 'AxXxXXxId',
      paymentMethods: ["momo", "card"],
    );
    return kkiapay;
  }

  void _successCallback(response, context) {
    switch (response['status']) {
      case PAYMENT_CANCELLED:
        onStatutPaiementsChanged({'code': Constants.CANCEL});

        Get.back();
        break;

      case PENDING_PAYMENT:
        onStatutPaiementsChanged({'code': Constants.PENDING});

        break;

      case PAYMENT_INIT:
        statusPaiement = Constants.INIT;
        break;

      case PAYMENT_SUCCESS:
        var data = {
          'amount': response['requestData']['amount'],
          'transactionId': response['transactionId'],
          'code': Constants.SUCCESS
        };
        onStatutPaiementsChanged(data);

        Get.back();
        break;

      case PAYMENT_FAILED:
        onStatutPaiementsChanged({'code': Constants.ERROR});
        Get.back();
        break;
      default:
        break;
    }
  }
}
