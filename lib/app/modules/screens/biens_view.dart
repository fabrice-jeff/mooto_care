import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../controllers/biens_controller.dart';

class BiensView extends GetView<BiensController> {
  const BiensView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextComponent(text: "Bonjour le monde de codeur"),
        ),
      ),
    );
  }
}
