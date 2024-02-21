import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../services/flashbag_message.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/intl_phone_field.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../controllers/security_controller.dart';

class LoginView extends StatelessWidget {
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  const LoginView({
    this.errors,
    this.oldData,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: LoginForm(errors: errors, oldData: oldData),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  const LoginForm({
    super.key,
    this.errors,
    this.oldData,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController password;

  @override
  void initState() {
    username = (widget.oldData == null)
        ? TextEditingController()
        : TextEditingController(text: widget.oldData!['username']);
    if (widget.errors == null && widget.oldData != null) {
      flashbagMessage(context, 'Identifiants incorrects', Colors.red);
    }
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SecurityController());

    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  Constants.logo,
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              (widget.errors != null && widget.errors!['username'] != null)
                  ? IntlPhoneFieldsComponent(
                      hintText: 'Téléphone',
                      controller: username,
                      enabledBorderColor: Colors.red,
                    )
                  : IntlPhoneFieldsComponent(
                      hintText: 'Téléphone',
                      controller: username,
                    ),
              SizedBox(
                height: 10,
              ),
              (widget.errors != null && widget.errors!['password'] != null)
                  ? TextFormFieldsComponent(
                      hintText: "Mot de passe",
                      obscureText: true,
                      prefixIcon: Icons.lock,
                      controller: password,
                      enabledBorderColor: Colors.red,
                    )
                  : TextFormFieldsComponent(
                      hintText: "Mot de passe",
                      obscureText: true,
                      prefixIcon: Icons.lock,
                      controller: password,
                    ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    //La connexion
                    Map<String, dynamic> data = {
                      'username': username.text,
                      'password': password.text,
                    };
                    controller.login(data);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  child: TextComponent(
                    text: "Connexion",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: TextComponent(
                    text: "Mot de passe oublié?",
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.REGISTER);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: TextComponent(
                    text: "Inscrivez-vous",
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
