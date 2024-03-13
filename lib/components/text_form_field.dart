import 'package:autocare/components/text.dart';
import 'package:autocare/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldsComponent extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Color enabledBorderColor;

  const TextFormFieldsComponent({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.textInputType = TextInputType.name,
    required this.controller,
    this.enabledBorderColor = Colors.black38,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.inputColor,
          ),
          hintText: hintText,
          label: TextComponent(text: hintText),
          hintStyle: TextStyle(color: AppColors.inputColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: enabledBorderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.backgroundColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
