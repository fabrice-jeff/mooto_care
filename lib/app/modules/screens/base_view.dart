import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../controllers/base_controller.dart';
import 'home_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
      builder: (_) => Scaffold(
        drawer: Drawer(child: MenuApp()),
        appBar: AppBar(
          title: Text("MootoCare"),
          actions: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage('assets/images/user.webp'),
                ),
              ),
              margin: EdgeInsets.only(right: 20),
            )
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.currentIndex,
            children: [
              HomeView(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.backgroundColor,
              currentIndex: controller.currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              selectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Accueil",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.settings_outlined,
                  ),
                  label: "Paramètres",
                ),
              ],
              onTap: controller.changeScreen,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [DrawerHeader(child: Container())],
    );
  }
}
