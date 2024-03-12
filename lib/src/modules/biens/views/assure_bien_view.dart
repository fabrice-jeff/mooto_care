import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../datas/models/bien.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/select_fields.dart';
import '../../../components/text.dart';
import '../controllers/biens_controller.dart';

class AssureBienView extends GetView<BiensController> {
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  final Bien? bien;
  AssureBienView(
      {Bien? bien, Map<String, dynamic>? errors, Map<String, dynamic>? oldData})
      : errors = errors ?? Get.arguments?['errors'],
        bien = bien ?? Get.arguments?['bien'],
        oldData = oldData ?? Get.arguments?['oldData'];

  @override
  Widget build(BuildContext context) {
    Get.put(BiensController());
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "Choisir une couverture",
          size: 20,
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
  final Bien? bien;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;

  const AssureBienForm({
    super.key,
    required this.controller,
    required this.bien,
    this.errors,
    this.oldData,
  });

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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(text: "Création d'une identité numérique"),
                      Container(
                        width: 24,
                        child: SvgPicture.asset(
                          Constants.forwardArrowIcon,
                          color: AppColors.backgroundColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(text: "Signaler la perte de votre moto"),
                      Container(
                        width: 24,
                        child: SvgPicture.asset(
                          Constants.forwardArrowIcon,
                          color: AppColors.backgroundColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(text: "Traçabilité de votre moto"),
                      Container(
                        width: 24,
                        child: SvgPicture.asset(
                          Constants.forwardArrowIcon,
                          color: AppColors.backgroundColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SelectFieldsWidget(
              hintText: "Niveau de couverture",
              icon: Icons.notes_sharp,
              label: "Niveau de couverture",
              items: widget.controller.couvertures,
              onValueChanged: handleSelectValue,
            ),
            if (widget.errors != null && widget.errors!['couverture'] != null)
              Container(
                alignment: Alignment.topLeft,
                child: TextComponent(
                  text: widget.errors!['couverture'][0],
                  textAlign: TextAlign.left,
                  color: Colors.red,
                ),
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
                if (widget.bien != null) {
                  Map<String, dynamic> data = {
                    'couverture': couverture,
                    'promotion': basiquePromotion,
                    'num_plaque': widget.bien!.numPlaque,
                  };
                  widget.controller.assureMoto(data, widget.bien!);
                }
                print(widget.bien);
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
