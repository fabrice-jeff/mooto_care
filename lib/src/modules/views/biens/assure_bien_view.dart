import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../datas/models/bien.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/select_fields.dart';
import '../../../components/text.dart';
import '../../controllers/biens_controller.dart';

class AssureBienView extends GetView<BiensController> {
  final Bien bien;
  const AssureBienView({required this.bien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: "Enregistrement d'une moto",
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
            child: AssureBienForm(controller: controller),
          ),
        ),
      ),
    );
  }
}

class AssureBienForm extends StatefulWidget {
  final BiensController controller;

  const AssureBienForm({super.key, required this.controller});

  @override
  State<AssureBienForm> createState() => _AssureBienFormState();
}

class _AssureBienFormState extends State<AssureBienForm> {
  String? couverture;
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
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextComponent(
                text: "Enregistrer",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
