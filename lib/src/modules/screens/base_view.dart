import 'package:autocare/src/components/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../controllers/base_controller.dart';
import 'home_view.dart';
import 'parametres_view.dart';
import 'plus_view.dart';
import 'tarifs_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
      builder: (_) => Scaffold(
        drawer: Drawer(child: MenuApp()),
        appBar: AppBar(
          title: TextComponent(
            text: "MootoCare",
            size: 24,
          ),
          actions: [
            Container(
              child: Icon(
                Icons.notifications_active_rounded,
                size: 20,
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
              TarifsView(),
              ParametresView(),
              PlusView(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.only(),
            child: BottomNavigationBar(
              backgroundColor: AppColors.backgroundColor,
              currentIndex: controller.currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              selectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(CupertinoIcons.home),
                  label: "Accueil",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.event_note_sharp,
                  ),
                  label: "Tarifs",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    CupertinoIcons.person_circle,
                  ),
                  label: "Compte",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.more_vert_outlined),
                  label: "Plus",
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
