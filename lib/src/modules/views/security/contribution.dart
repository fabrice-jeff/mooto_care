import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/intl_phone_field.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../../controllers/security_controller.dart';

class ContributionView extends StatelessWidget {
  final Map<String, dynamic> data;
  const ContributionView({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: ContributionForm(data: data)),
      ),
    );
  }
}

class ContributionForm extends StatefulWidget {
  final Map<String, dynamic> data;
  const ContributionForm({super.key, required this.data});

  @override
  State<ContributionForm> createState() => _ContributionFormState();
}

class _ContributionFormState extends State<ContributionForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController montant = TextEditingController();

  final int _nombreMontant = 7;
  int _boutonSelectionne = -1;
  List<int> _valeurs = List.generate(7, (index) => 100 * (index + 1));

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SecurityController());
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextComponent(
                  text:
                      'Nous vous invitons à souscrire à un frais forfaitaire afin de soutenir nos créateurs et contribuer au maintien du système.',
                  textAlign: TextAlign.justify,
                  size: 17,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(text: 'Montant'),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.info_outline),
                    ),
                  ],
                ),
              ),
              TextFormFieldsComponent(
                textInputType: TextInputType.number,
                hintText: "",
                prefixIcon: Icons.monetization_on,
                controller: montant,
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          width: double.maxFinite,
                          height: 1.6,
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1.6,
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextComponent(
                            text: "ou",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.topLeft,
                child: TextComponent(
                  text: "Sélectionner un montant",
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                width: double.infinity,
                // padding: EdgeInsets.symmetric(horizontal: 5),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    _nombreMontant,
                    (index) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: _boutonSelectionne == index
                                ? MaterialStateProperty.all<Color>(Colors.blue)
                                : MaterialStateProperty.all<Color>(
                                    Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _boutonSelectionne =
                                  index; // Mettre à jour le bouton sélectionné
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${_valeurs[index]} F",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Enregistrement dans la base de donnée
              InkWell(
                onTap: () {
                  // Faire l'enregistrement
                  // if (montant.text != null &&
                  //     _valeurs[_boutonSelectionne] != null) {
                  //   widget.data['amount'] = _valeurs[_boutonSelectionne];
                  // }
                  if (montant.text.isNotEmpty) {
                    widget.data['amount'] = montant.text;
                  } else if (montant.text.isEmpty && _boutonSelectionne != -1) {
                    widget.data['amount'] = _valeurs[_boutonSelectionne];
                  }
                  controller.register(widget.data);
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
                    text: "Enregistrer",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
