import 'package:autocare/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/security_controller.dart';

class VerificationCodeView extends GetView<SecurityController> {
  final Map<String, dynamic> data;
  VerificationCodeView({super.key, Map<String, dynamic>? data})
      : data = data ?? Get.arguments?['data'];

  @override
  Widget build(BuildContext context) {
    Get.put(SecurityController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: VerificationCodeForm(
            controller: controller,
            data: data,
          ),
        ),
      ),
    );
  }
}

class VerificationCodeForm extends StatefulWidget {
  final SecurityController controller;
  final Map<String, dynamic> data;
  const VerificationCodeForm({
    super.key,
    required this.controller,
    required this.data,
  });

  @override
  State<VerificationCodeForm> createState() => _VerificationCodeFormState();
}

class _VerificationCodeFormState extends State<VerificationCodeForm> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/verification_code.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  // padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(
                              first: true,
                              last: false,
                              controller: _otpController1),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController2),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController3),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController4),
                          _textFieldOTP(
                              first: false,
                              last: true,
                              controller: _otpController5),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Récupérer le code
                            var code =
                                '${_otpController1.text}${_otpController2.text}${_otpController3.text}${_otpController4.text}${_otpController5.text}';
                            Map<String, dynamic> data = {
                              'code': code,
                              'email': widget.data['email']
                            };

                            // Vérifier si le code est correct
                            widget.controller.verificationCodeEmail(data);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.backgroundColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Vérifier',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Vous n'avez pas reçu de code ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Renvoyer un nouveau code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({
    TextEditingController? controller,
    bool? first,
    last,
  }) {
    return Expanded(
      child: Container(
        height: 85,
        margin: EdgeInsets.all(5),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: AppColors.backgroundColor),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
