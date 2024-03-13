import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../../components/no_data.dart';
import '../../../components/text.dart';
import '../../../utils/constants.dart';
import '../controllers/plaintes_controller.dart';

class PlaintesView extends GetView<PlaintesController> {
  const PlaintesView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: 'Plaintes déposées',
          size: 20,
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GetBuilder<PlaintesController>(
                builder: (_) => (controller.plaintesDeposes.length == 0)
                    ? NoData(
                        text: "Aucune plainte déposée",
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
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Constants.plainte,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  // leading: Icon(Icons.list_alt),
                                  title: TextComponent(
                                    text: "Plainte HGJH656838".toUpperCase(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: TextComponent(
                                    text:
                                        "plaque: ${controller.plaintesDeposes[position].bien.numPlaque}"
                                            .toUpperCase(),
                                  ),
                                  trailing: Icon(Icons.more_vert),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return Divider();
                        },
                        itemCount: controller.plaintesDeposes.length,
                      ),
              )),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: AppColors.backgroundColor,
              onPressed: () {},
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              heroTag: null,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              backgroundColor: AppColors.backgroundColor,
              onPressed: () {
                Get.toNamed(Routes.ADD_PLAINTE);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              heroTag: null,
            ),
          ],
        ),
      ),
    );
  }
}
