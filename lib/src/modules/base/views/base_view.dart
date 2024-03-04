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
    "name": "Assurance biens divers",
    'route': Routes.ADD_BIEN,
  },
  {
    "name": "Prestations divers",
    "route": null,
  },
  {
    "name": "Parametres",
    "route": Routes.ADD_PLAINTE,
  },
  {
    "name": "Deconnexion",
    "route": Routes.ADD_PLAINTE,
  }
];

class MenuApp extends StatefulWidget {
  final Acteur? acteur;
  const MenuApp({super.key, required this.acteur});

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  bool _isVisiblePrestation = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          // padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 110,
                  height: 110,
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
              Container(
                child: TextComponent(
                  text: (widget.acteur!.nom + " " + widget.acteur!.prenoms)
                      .toUpperCase(),
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
                    if (menuItemList[i]['route'] == null) {
                      setState(() {
                        _isVisiblePrestation = !_isVisiblePrestation;
                      });
                    } else {
                      Get.toNamed(menuItemList[i]['route']);
                    }
                  },
                  title: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: (menuItemList[i]['route'] == null)
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextComponent(
                                  size: 14,
                                  textAlign: TextAlign.left,
                                  text: menuItemList[i]['name']
                                      .toString()
                                      .toUpperCase(),
                                ),
                                if (_isVisiblePrestation)
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextComponent(
                                          size: 14,
                                          text:
                                              "Item A".toString().toUpperCase(),
                                        ),
                                        TextComponent(
                                          size: 14,
                                          text:
                                              "Item B".toString().toUpperCase(),
                                        ),
                                        TextComponent(
                                          size: 14,
                                          text:
                                              "Item C".toString().toUpperCase(),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          )
                        : TextComponent(
                            size: 14,
                            text: menuItemList[i]['name']
                                .toString()
                                .toUpperCase(),
                          ),
                  ),
                  trailing: (menuItemList[i]['route'] == null)
                      ? (_isVisiblePrestation)
                          ? Container(
                              width: 24, // Largeur spécifique pour le conteneur
                              child: SvgPicture.asset(
                                Constants.downArrowIcon,
                                color: AppColors.backgroundColor,
                              ),
                            )
                          : Container(
                              width: 24, // Largeur spécifique pour le conteneur
                              child: SvgPicture.asset(
                                Constants.forwardArrowIcon,
                                color: AppColors.backgroundColor,
                              ),
                            )
                      : null,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
