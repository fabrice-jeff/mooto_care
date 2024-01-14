import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/line.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../../controllers/security_controller.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: RegisterForm()),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nom = TextEditingController();
  TextEditingController prenoms = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool acceptCondiction = false;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SecurityController());
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Nom",
                prefixIcon: Icons.person,
                controller: nom,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Prénoms",
                prefixIcon: Icons.person,
                controller: prenoms,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Email",
                prefixIcon: Icons.email,
                controller: email,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Téléphone",
                prefixIcon: Icons.phone,
                controller: telephone,
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                      value: acceptCondiction,
                      activeColor: AppColors.backgroundColor,
                      onChanged: (value) {
                        setState(() {
                          acceptCondiction = !acceptCondiction;
                        });
                      }),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          acceptCondiction = !acceptCondiction;
                        });
                      },
                      child: Container(
                        child: TextComponent(
                          text:
                              "En vous inscrivant, vous acceptez les condictions et règlements de la plateforme",
                          size: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // print("Nom ${nom.text}");
                    // print("Prénoms ${prenoms.text}");
                    // print("Email ${email.text}");
                    // print("Téléphone ${telephone.text}");
                    // print("Password ${password.text}");
                    // print("Accept Condiction ${acceptCondiction}");

                    Map<String, dynamic> data = {
                      'name': nom.text,
                      'prenoms': prenoms.text,
                      'email': email.text,
                      'telephone': telephone.text,
                      'password': password.text,
                    };
                    controller.register(data);
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
                    text: "Créer un compte",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: TextComponent(
                        text: "Vous avez déja un compte?",
                        color: AppColors.backgroundColor,
                        size: 15,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.LOGIN);
                    },
                    child: Container(
                      child: TextComponent(
                        text: "Connectez-vous",
                        color: AppColors.backgroundColor,
                        size: 15,
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
