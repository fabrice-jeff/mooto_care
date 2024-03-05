import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/text.dart';
import '../controllers/plaintes_controller.dart';

class HomePlainteView extends GetView<PlaintesController> {
  const HomePlainteView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: 'Dépot d\'une plainte',
          size: 20,
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/3156704.jpg"),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                child: TextComponent(
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  text: "Vous n'avez pas encore une attestation de perte? ",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.DEMANDE_ATTESTATION);
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextComponent(
                          text: "Faire une demande d'attestation",
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.add_task,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextComponent(
                            text: "OU",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.ADD_PLAINTE);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextComponent(
                          text: "Déposer une  plainte",
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.add_card,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
