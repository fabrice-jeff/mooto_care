import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

String? selectedValue;

class SelectFieldsWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String label;
  final List<String> items;
  final void Function(String?) onValueChanged;

  const SelectFieldsWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.label,
    required this.items,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: DropdownButtonFormField2<String>(
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.backgroundColor),
                  borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(
                icon,
                color: Colors.black38,
              ),
            ),
            hint: Text(
              hintText,
              style: TextStyle(fontSize: 15, color: Colors.black38),
            ),

            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black38,
                        ),
                      ),
                    ))
                .toList(),
            // validator: (value) {
            //   if (value == null) {
            //     return 'Please select gender.';
            //   }
            //   return null;
            // }
            onChanged: (value) {
              onValueChanged(value);
            },
            onSaved: (value) {
              selectedValue = value.toString();
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.only(right: 10),
            ),

            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black38,
                size: 20,
              ),
              iconSize: 18,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}
