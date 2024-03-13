import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';
import 'notification_item.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const NotificationItem(),
              shrinkWrap: true,
              primary: false,
            ),
          ],
        ),
      ),
    );
  }
}
