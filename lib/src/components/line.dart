import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class LineComponnent extends StatelessWidget {
  final double width;
  final Alignment alignment;
  const LineComponnent(
      {super.key, required this.width, this.alignment = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        height: 10,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
