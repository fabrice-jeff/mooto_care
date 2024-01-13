import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/line.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../../controllers/security_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: LoginForm()),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController telephone = TextEditingController();
  TextEditingController password = TextEditingController();
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
                child: TextComponent(
                  text: "AUTOCARE",
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                  size: 25,
                ),
              ),
              LineComponnent(
                width: 100,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 50,
              ),
              TextFormFieldsComponent(
                hintText: "Téléphone",
                prefixIcon: Icons.phone,
                controller: telephone,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Mot de passe",
                obscureText: true,
                prefixIcon: Icons.lock,
                controller: password,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: "Mot de passe oublié ?",
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    //La connexion

                    Map<String, dynamic> data = {
                      'username': telephone.text,
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
                height: 5,
              ),
              // InkWell(
              //   onTap: _handleSignIn,
              //   child: Container(
              //     alignment: Alignment.center,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: AppColors.backgroundColor,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     height: 50,
              //     child: TextComponent(
              //       text: " Google Sign ",
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: TextComponent(
                        text: "Pas de compte ?",
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.REGISTER);
                    },
                    child: Container(
                      child: TextComponent(
                        text: "Inscrivez-vous",
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
