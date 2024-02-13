import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendMail {
  final String recipient;
  final String subject;
  final String content;
  const SendMail(
      {required this.recipient, required this.subject, required this.content});

  void _sendEmail() async {
    String username = 'mootocare@gmail.com';
    String password = 'eetpstzywrvxyntb';
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'MootoCare Service')
      ..recipients.add(recipient)
      ..subject = subject
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
