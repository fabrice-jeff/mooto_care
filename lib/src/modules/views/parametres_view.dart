import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../components/settings_item.dart';

class ParametresView extends GetView {
  const ParametresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SettingsItem(
                title: 'Mike Tyson',
                icon: Constants.user,
                isAccount: true,
              ),
              const SettingsItem(
                title: 'Partagez l\'application',
                icon: Constants.share,
              ),
              const SettingsItem(
                title: 'Dark Mode',
                icon: Constants.themeIcon,
                isDark: true,
              ),
              const SettingsItem(
                title: 'Language',
                icon: Constants.languageIcon,
              ),
              const SettingsItem(
                title: 'Aide',
                icon: Constants.helpIcon,
              ),
              const SettingsItem(
                title: 'Deconnexion',
                icon: Constants.logoutIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
