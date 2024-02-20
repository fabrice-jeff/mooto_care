import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../datas/models/bien.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/select_fields.dart';
import '../../../components/text.dart';
import '../controllers/biens_controller.dart';

class AssureBienView extends GetView<BiensController> {
  final Bien bien;
  const AssureBienView({required this.bien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: "Choisir une couverture",
            size: 20,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: AssureBienForm(controller: controller, bien: bien),
          ),
        ),
      ),
    );
  }
}

class AssureBienForm extends StatefulWidget {
  final BiensController controller;
  final Bien bien;

  const AssureBienForm(
      {super.key, required this.controller, required this.bien});

  @override
  State<AssureBienForm> createState() => _AssureBienFormState();
}

class _AssureBienFormState extends State<AssureBienForm> {
  String? couverture;
  bool basiquePromotion = false;

  @override
  void initState() {
    super.initState();
    widget.controller.showPromotion = false;
  }

  void handleSelectValue(String? selectedValue) {
    for (var couv in widget.controller.typesCouvertures) {
      if (selectedValue == couv.libelle) {
        couverture = couv.codeReference;
        break;
      }
    }
    if (couverture == Constants.TYPE_COUVERTURE_BASIQUE) {
      widget.controller.showPromo(true);
    } else {
      widget.controller.showPromo(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiensController>(
      builder: (controller) => Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: TextComponent(
                text: widget.bien.nomBien,
                fontWeight: FontWeight.bold,
                size: 30,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SelectFieldsWidget(
              hintText: "Niveau de couverture",
              icon: Icons.notes_sharp,
              label: "Niveau de couverture",
              items: widget.controller.couvertures,
              onValueChanged: handleSelectValue,
            ),
            if (widget.controller.showPromotion == true)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoSwitch(
                      value: basiquePromotion,
                      onChanged: (value) {
                        setState(() {
                          basiquePromotion = !basiquePromotion;
                        });
                      },
                      activeColor: AppColors.backgroundColor,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            basiquePromotion = !basiquePromotion;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          child: TextComponent(
                            text: "80% sur le niveau basique",
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Map<String, dynamic> data = {
                  'couverture': couverture,
                  'promotion': basiquePromotion,
                  'code_bien': widget.bien.code
                };
                widget.controller.assureMoto(data);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextComponent(
                  text: "Assurez votre moto",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
