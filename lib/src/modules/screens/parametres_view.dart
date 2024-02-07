import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text.dart';

class ParametresView extends GetView {
  const ParametresView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextComponent(
          text: "Parametres",
        ),
      ),
    );
  }
}
