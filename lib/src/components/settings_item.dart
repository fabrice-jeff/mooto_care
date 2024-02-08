import 'package:autocare/src/components/text.dart';
import 'package:autocare/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;
  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListTile(
        title: Text(title,
            style: theme.textTheme.displayMedium?.copyWith(
              fontSize: 16,
            )),
        subtitle: !isAccount
            ? null
            : TextComponent(
                text: '+218 92 00 000 00',
              ),
        leading: CircleAvatar(
          radius: isAccount ? 30 : 25,
          backgroundColor: AppColors.backgroundColor,
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.none,
            color: Colors.white,
          ),
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            Constants.forwardArrowIcon,
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}
