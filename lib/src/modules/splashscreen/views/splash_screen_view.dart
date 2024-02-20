import 'package:autocare/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.backgroundColor, Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: Image.asset(
            Constants.logo,
            width: 130,
            height: 150,
          ).animate().scale(duration: 800.ms, begin: const Offset(0, 1)),
        ),
      ),
    );
  }
}
