import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../components/text.dart';
import '../controllers/base_controller.dart';
import 'home_view.dart';
import 'notifications/notifications_views.dart';
import 'parametres_view.dart';
import 'tarifs_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return GetBuilder<BaseController>(
      builder: (_) => Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: MenuApp(),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              Constants.user,
              color: Colors.black,
              width: 30,
              height: 30,
            ), // Icône par défaut du Drawer (menu)
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Expanded(
            child: Center(
              child: TextComponent(
                text: "MOOTOCARE",
                size: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Container(
              child: SvgPicture.asset(
                Constants.codeQr,
                width: 30,
                height: 30,
              ),
              margin: EdgeInsets.only(right: 5),
            )
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.currentIndex,
            children: [
              HomeView(),
              TarifsView(),
              NotificationsView(),
              ParametresView(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedFontSize: 0.0,
              items: [
                _mBottomNavItem(
                  label: 'Home',
                  icon: Constants.homeIcon,
                ),
                _mBottomNavItem(
                  label: 'Tarif',
                  icon: Constants.note,
                ),
                _mBottomNavItem(
                  label: 'Notifications',
                  icon: Constants.notificationsIcon,
                ),
                _mBottomNavItem(
                  label: 'Settings',
                  icon: Constants.settingsIcon,
                ),
              ],
              onTap: controller.changeScreen,
            ),
          ),
        ),
      ),
    );
  }

  _mBottomNavItem({required String label, required String icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        icon,
        color: Colors.black45,
        width: 25,
        height: 25,
      ),
      activeIcon: SvgPicture.asset(
        icon,
        color: AppColors.backgroundColor,
        width: 25,
        height: 25,
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
