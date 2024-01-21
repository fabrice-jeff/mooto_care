import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ComtainerRoundComponent extends StatelessWidget {
  final double height;
  final IconData icon;
  final double width;
  const ComtainerRoundComponent({
    super.key,
    required this.height,
    required this.width,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(width),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
