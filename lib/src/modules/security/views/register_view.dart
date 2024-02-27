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

class RegisterView extends GetView<SecurityController> {
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  const RegisterView({
    super.key,
    this.errors,
    this.oldData,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(SecurityController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RegisterForm(
            controller: controller,
            errors: errors,
            oldData: oldData,
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final SecurityController controller;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  const RegisterForm(
      {super.key, required this.controller, this.errors, this.oldData});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nom;
  late TextEditingController prenoms;
  late TextEditingController email;
  late TextEditingController telephone;
  late TextEditingController password;
  late TextEditingController passwordConfirm;

  @override
  void initState() {
    nom = (widget.oldData == null)
        ? TextEditingController()
        : TextEditingController(text: widget.oldData!['nom']);
    prenoms = (widget.oldData == null)
        ? TextEditingController()
        : TextEditingController(text: widget.oldData!['prenoms']);
    email = (widget.oldData == null)
        ? TextEditingController()
        : TextEditingController(text: widget.oldData!['email']);
    telephone = (widget.oldData == null)
        ? TextEditingController()
        : TextEditingController(text: widget.oldData!['telephone']);
    password = TextEditingController();
    passwordConfirm = TextEditingController();
    super.initState();
  }

  bool acceptCondiction = false;
  @override
  Widget build(BuildContext context) {
    Get.put(SecurityController());
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
                child: Image.asset(
                  Constants.logo,
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Nom",
                prefixIcon: Icons.person,
                controller: nom,
              ),
              if (widget.errors != null && widget.errors!['nom'] != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: widget.errors!['nom'][0],
                    textAlign: TextAlign.left,
                    color: Colors.red,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Prénoms",
                prefixIcon: Icons.person,
                controller: prenoms,
              ),
              if (widget.errors != null && widget.errors!['prenoms'] != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: widget.errors!['prenoms'][0],
                    textAlign: TextAlign.left,
                    color: Colors.red,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Email",
                prefixIcon: Icons.email,
                controller: email,
              ),
              if (widget.errors != null && widget.errors!['email'] != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: widget.errors!['email'][0],
                    textAlign: TextAlign.left,
                    color: Colors.red,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              IntlPhoneFieldsComponent(
                hintText: 'Téléphone',
                controller: telephone,
              ),
              if (widget.errors != null && widget.errors!['telephone'] != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: widget.errors!['telephone'][0],
                    textAlign: TextAlign.left,
                    color: Colors.red,
                  ),
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
              if (widget.errors != null && widget.errors!['password'] != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: widget.errors!['password'][0],
                    textAlign: TextAlign.left,
                    color: Colors.red,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldsComponent(
                hintText: "Confirmation mot de passe",
                obscureText: true,
                prefixIcon: Icons.lock,
                controller: passwordConfirm,
              ),
              if (widget.errors != null &&
                  widget.errors!['password_confirmation'] != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: widget.errors!['password_confirmation'][0],
                    textAlign: TextAlign.left,
                    color: Colors.red,
                  ),
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
                    Map<String, dynamic> data = {
                      'nom': nom.text,
                      'prenoms': prenoms.text,
                      'email': email.text,
                      'telephone': telephone.text,
                      'password': password.text,
                      'password_confirmation': passwordConfirm.text,
                    };
                    print(data);
                    if (acceptCondiction) {
                      widget.controller.register(data);
                    } else {
                      flashbagMessage(
                          context,
                          "Vous devez accepter les condictions d'utilisation la création du compte",
                          Colors.redAccent);
                    }
                    // Enregistrement d'un utilisateur dans la base
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
        ),
      ),
    );
  }
}
