import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../components/no_data.dart';
import '../../../components/text.dart';
import '../controllers/biens_controller.dart';
import 'bien_view.dart';

class BiensView extends GetView<BiensController> {
  const BiensView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: 'Motos enregistrées',
          size: 20,
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GetBuilder<BiensController>(
                builder: (_) => (controller.biensByActeur.length == 0)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NoData(
                            text: "Vous n'avez enregistré aucune moto",
                          ),
                        ],
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          return Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              child: Center(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(
                                      BienView(
                                        bien:
                                            controller.biensByActeur[position],
                                      ),
                                    );
                                  },
                                  title: TextComponent(
                                    text: controller
                                        .biensByActeur[position].nomBien,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: TextComponent(
                                      text:
                                          "Numéro d'immatriculation: ${controller.biensByActeur[position].numPlaque}",
                                      size: 13,
                                    ),
                                  ),
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Constants.bien,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  trailing: (controller.biensByActeur[position]
                                              .typeCouverture ==
                                          null)
                                      ? Icon(
                                          Icons.not_interested,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.verified,
                                          color: Colors.green,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return Divider();
                        },
                        itemCount: controller.biensByActeur.length,
                      ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundColor,
        onPressed: () {
          Get.toNamed(Routes.ADD_BIEN);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        heroTag: null,
      ),
    );
  }
}
