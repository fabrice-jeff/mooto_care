import 'dart:convert';

import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../datas/models/acteur.dart';
import '../../../datas/models/deamende_attestaion.dart';
import '../../../datas/models/plainte.dart';
import '../../../datas/repository/plaintes.dart';
import '../../../generated_attestation.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/share_preference.dart';
import '../../api.dart';

class PlaintesController extends GetxController {
  List<Plainte> plaintesDeposes = [];
  PlainteRepository _plainteRepository = PlainteRepository(api: Api.BASE_URL);
  Acteur? acteur = SharePreferences.getActeur();

  @override
  void onInit() {
    super.onInit();
    getPlaintesDeposes();
  }

  // Ajout d'une demande d'attestation de perte
  addDemandeAttestation(Map<String, dynamic> data) async {
    // Générer le fichier PDF

    // Demande de paiement
    // await Get.to(
    //   _initPaiement(
    //     amount: 500,
    //     name: acteur!.nom + " " + acteur!.prenoms,
    //     email: acteur!.email,
    //   ),
    // );
    // // Confirmation du succes du paiement
    // if (statusPaiement == Constants.SUCCESS) {
    data['code_acteur'] = acteur!.code;
    var result = await _plainteRepository.addDemandeAttestation(data);

    if (result!['code'] == Constants.SUCCESS) {
      var bien = jsonDecode(result['bien']);
      bien['acteur'] = jsonDecode(result['acteur']);

      var demande = jsonDecode(result['demande_attestation']);
      demande['bien'] = bien;

      DemandeAttestation demandeAttestation =
          DemandeAttestation.fromJson(demande);

      // Générer le fichier PDF
      final pdfData = await generatePDF(demandeAttestation);
      String base64Data = base64Encode(pdfData);
      String filename = demandeAttestation.code + ".pdf";
      Map<String, dynamic> data = {
        'pdf_data': base64Data,
        'filename': filename
      };
      _plainteRepository.uploadPdf(data);

      // Envoyer un email
      // _sendEmail(
      //   recipient: acteur!.email,
      //   subject: "Paiement",
      //   content: "Votre paiements a été effectué avec succès",
      // );
      // Get.toNamed(Routes.BASE);
    } else {
      Get.toNamed(Routes.DEMANDE_ATTESTATION);
    }
    // }
    update();
  }

  // Ajout d'une plainte
  addPlainte(Map<String, dynamic> data) async {
    // Demande de paiement
    // await Get.to(
    //   _initPaiement(
    //     amount: 200,
    //     name: acteur!.nom + " " + acteur!.prenoms,
    //     email: acteur!.email,
    //   ),
    // );
    // if (statusPaiement == Constants.SUCCESS) {
    data['code_acteur'] = acteur!.code;
    var results = await _plainteRepository.addPlainte(data);
    print(results);

    if (results!['code'] == Constants.SUCCESS) {
      getPlaintesDeposes();
      Get.toNamed(Routes.PLAINTES);
    } else {
      Get.toNamed(Routes.ADD_PLAINTE);
    }
    // }

    update();
  }

  getPlaintesDeposes() async {
    plaintesDeposes = await _plainteRepository.allPlaintes();
    update();
  }

  void _sendEmail({
    required String recipient,
    required String subject,
    required String content,
  }) async {
    String username = 'mootocare@gmail.com';
    // String password = 'eetp stzy wrvx yntb';
    String password = 'eetpstzywrvxyntb';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'MootoCare Service')
      ..recipients.add(recipient)
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = subject
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.!'
      ..html = content;

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
