import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../components/text.dart';

class AddBienView extends GetView {
  const AddBienView();
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
