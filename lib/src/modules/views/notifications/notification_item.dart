import 'package:autocare/src/components/text.dart';
import 'package:autocare/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: TextComponent(
          text: 'New Notification received',
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            '10/06/2022 AT 05:30 PM',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 12,
            ),
          ),
        ),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: SvgPicture.asset(
              Constants.notificationsIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
