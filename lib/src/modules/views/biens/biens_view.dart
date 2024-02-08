import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/no_data.dart';
import '../../../components/text.dart';
import '../../controllers/biens_controller.dart';

class BiensView extends GetView<BiensController> {
  const BiensView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: 'Motos enregistrées',
            size: 20,
          ),
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
                                  leading: Icon(Icons.list_alt),
                                  title: TextComponent(
                                    text: controller
                                        .biensByActeur[position].nomBien,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: TextComponent(
                                    text:
                                        "Num: ${controller.biensByActeur[position].numPlaque}",
                                  ),
                                  trailing: Icon(Icons.edit),
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
      // Container(
      //   alignment: Alignment.bottomRight,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //         backgroundColor: AppColors.backgroundColor,
      //         onPressed: () {},
      //         child: Icon(
      //           Icons.search,
      //           color: Colors.white,
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
