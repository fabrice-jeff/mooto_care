import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/no_data.dart';
import '../../../components/text.dart';
import '../../controllers/plaintes_controller.dart';

class PlaintesView extends GetView<PlaintesController> {
  const PlaintesView();
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
          text: "Plaintes déposées",
          color: Colors.white,
        ),
        actions: [
          InkWell(
            child: Container(
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 20),
            ),
          )
        ],
        backgroundColor: AppColors.backgroundColor,
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
                                  leading: Icon(Icons.list_alt),
                                  title: TextComponent(
                                    text: controller
                                        .plaintesDeposes[position].nomBien,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: TextComponent(
                                    text:
                                        "Num: ${controller.plaintesDeposes[position].numeroPlaque}",
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
