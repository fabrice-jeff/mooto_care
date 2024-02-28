import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../datas/models/acteur.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/text.dart';
import '../../notifications/views/notifications_views.dart';
import '../controllers/base_controller.dart';
import '../../home/views/home_view.dart';
import '../../views/parametres_view.dart';
import '../../views/tarifs_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(BaseController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return GetBuilder<BaseController>(
      builder: (_) => Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: MenuApp(
            acteur: controller.acteur,
          ),
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

List<Map<String, dynamic>> menuItemList = [
  {
    "name": "Assurence biens divers",
    'route': Routes.ADD_BIEN,
  },
  {
    "name": "Autres prestations",
    "route": Routes.ADD_PLAINTE,
  }
];

class MenuApp extends StatelessWidget {
  final Acteur? acteur;
  const MenuApp({super.key, required this.acteur});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/user.webp",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextComponent(
                  text: (acteur!.nom + " " + acteur!.prenoms).toUpperCase(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              for (int i = 0; i < menuItemList.length; i++)
                ListTile(
                  onTap: () {
                    Get.toNamed(menuItemList[i]['route']);
                  },
                  title: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextComponent(
                        text: menuItemList[i]['name'],
                      )),
                  trailing: SvgPicture.asset(
                    Constants.forwardArrowIcon,
                    color: AppColors.backgroundColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
