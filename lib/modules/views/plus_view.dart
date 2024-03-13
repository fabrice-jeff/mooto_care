import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../components/text.dart';

class PlusView extends GetView {
  const PlusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              width: double.infinity,
              height: 160,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextComponent(
                    text: "Partager l'application",
                    size: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.share_sharp)
                ],
              )),
        ),
      ),
    );
  }
}
