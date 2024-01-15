import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'text.dart';

class NoData extends StatelessWidget {
  final String text;
  const NoData({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Constants.NO_DATA),
        TextComponent(
          text: text,
          size: 20,
        ),
      ],
    );
  }
}
