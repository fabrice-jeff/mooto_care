import 'package:autocare/src/components/text.dart';
import 'package:autocare/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class IntlPhoneFieldsComponent extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;

  const IntlPhoneFieldsComponent({
    super.key,
    required this.hintText,
    this.textInputType = TextInputType.name,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: IntlPhoneField(
        controller: controller,
        focusNode: FocusNode(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          hintText: hintText,
          label: TextComponent(text: hintText),
          hintStyle: TextStyle(color: AppColors.inputColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
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
        languageCode: "fr",
        onChanged: (phone) {
          print(phone.completeNumber);
        },
        onCountryChanged: (country) {
          print('Country changed to: ' + country.name);
        },
        searchText: "Sélectionner un pays",
      ),
    );
  }
}
