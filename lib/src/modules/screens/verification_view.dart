import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../components/no_data.dart';
import '../../components/text.dart';
import '../../components/text_form_field.dart';
import '../controllers/biens_controller.dart';

class VerificationView extends GetView<BiensController> {
  const VerificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: TextComponent(
          text: "Vérification",
          color: Colors.white,
        ),
        // actions: [InkWell(child: Icon(Icons.notifications))],
        backgroundColor: AppColors.backgroundColor,
      ),
      body: GetBuilder<BiensController>(builder: (_) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (controller.bienByNum == null)
                    ? NoData(
                        text: "Aucune vérification en cours",
                      )
                    : Expanded(
                        child: Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(75),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/user.webp'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _rowInformation(
                                      label: "Nom:",
                                      value: controller
                                              .bienByNum!.acteur.nom[0] +
                                          ". " +
                                          controller.bienByNum!.acteur.prenoms),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _rowInformation(
                                    label: "Domicile:",
                                    value: controller.bienByNum!.adresse,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _rowInformation(
                                    label: "Télephone:",
                                    value:
                                        controller.bienByNum!.acteur.telephone,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _rowInformation(
                                    label: "Nom du bien:",
                                    value: controller.bienByNum!.nomBien,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _rowInformation(
                                    label: "Numero Plaque:",
                                    value: controller.bienByNum!.numPlaque,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _rowInformation(
                                    label: "Numero Chassis:",
                                    value: controller.bienByNum!.numChassis,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return NumPlaqueForm(controller: controller);
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.confirmation_number_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextComponent(
                                  text: "Plaque",
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextComponent(
                                  text: "Scanner",
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _rowInformation({required String label, required dynamic value}) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: TextComponent(
                text: label,
                fontWeight: FontWeight.bold,
                size: 17,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: TextComponent(
                text: value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumPlaqueForm extends StatefulWidget {
  final BiensController controller;
  const NumPlaqueForm({super.key, required this.controller});

  @override
  State<NumPlaqueForm> createState() => _NumPlaqueFormState();
}

class _NumPlaqueFormState extends State<NumPlaqueForm> {
  TextEditingController numPlaque = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.cancel_rounded,
                color: AppColors.backgroundColor,
                size: 35,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormFieldsComponent(
            hintText: "Numéro d'immatriculation",
            prefixIcon: Icons.confirmation_number_outlined,
            controller: numPlaque,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              widget.controller.getByNum(numPlaque.text);
              Get.back();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextComponent(
                  text: "Vérification par numéro plaque",
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
