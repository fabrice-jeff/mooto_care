import 'package:get/get.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/plainte.dart';
import '../../../datas/repository/plaintes.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';

class PlaintesController extends GetxController {
  List<Plainte> plaintesDeposes = [];
  PlainteRepository _plainteRepository = PlainteRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();
  late String statusPaiement;
  String username = 'mootocare@gmail.com';
  String password = 'MootoCare2024';

  @override
  void onInit() {
    super.onInit();
    getPlaintesDeposes();
  }

  // Ajout d'une demande d'attestation de perte
  addDemandeAttestation(Map<String, dynamic> data) async {
    // Demande de paiement
    await Get.to(
      _initPaiement(
        amount: 500,
        name: acteur!.nom + " " + acteur!.prenoms,
        email: acteur!.email,
      ),
    );

    if (statusPaiement == Constants.SUCCESS) {
      data['code_acteur'] = acteur!.code;
      var result = await _plainteRepository.addDemandeAttestation(data);
      if (result!['code'] == Constants.SUCCESS) {
        _sendEmail(username: username, password: password);
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.DEMANDE_ATTESTATION);
      }
    }
    update();
  }

  // Ajout d'une plainte
  addPlainte(Map<String, dynamic> data) async {
    // Demande de paiement
    await Get.to(
      _initPaiement(
        amount: 200,
        name: acteur!.nom + " " + acteur!.prenoms,
        email: acteur!.email,
      ),
    );
    if (statusPaiement == Constants.SUCCESS) {
      data['code_acteur'] = acteur!.code;
      var results = await _plainteRepository.addPlainte(data);

      if (results!['code'] == Constants.SUCCESS) {
        getPlaintesDeposes();
        Get.toNamed(Routes.PLAINTES);
      } else {
        Get.toNamed(Routes.ADD_PLAINTE);
      }
    }

    update();
  }

  getPlaintesDeposes() async {
    plaintesDeposes = await _plainteRepository.allPlaintes();
    update();
  }

  KKiaPay _initPaiement(
      {required int amount,
      required String name,
      required String email,
      bool sandbox = true}) {
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
        statusPaiement = Constants.CANCEL;
        Get.back();
        break;

      case PENDING_PAYMENT:
        statusPaiement = Constants.PENDING;

        break;

      case PAYMENT_INIT:
        statusPaiement = Constants.INIT;
        break;

      case PAYMENT_SUCCESS:
        statusPaiement = Constants.SUCCESS;
        Get.back();
        break;

      case PAYMENT_FAILED:
        statusPaiement = Constants.ERROR;
        Get.back();
        break;
      default:
        break;
    }
  }

  void _sendEmail({required String username, required String password}) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('mootocare@gmail.com')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
