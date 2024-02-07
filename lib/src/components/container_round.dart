import 'package:flutter/material.dart';

class ComtainerRoundComponent extends StatelessWidget {
  final double height;
  final IconData icon;
  final double width;
  final Color color;
  final Color containerColor;
  final double size;
  final Color borderColor;
  const ComtainerRoundComponent(
      {super.key,
      required this.height,
      required this.width,
      required this.icon,
      this.color = Colors.white,
      this.containerColor = const Color.fromARGB(255, 109, 161, 224),
      this.size = 50,
      this.borderColor = Colors.black26});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(width),
      ),
      child: Icon(
        color: color,
        icon,
        size: size,
      ),
    );
  }
}
