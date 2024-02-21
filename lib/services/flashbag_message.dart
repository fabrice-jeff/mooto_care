import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:flutter/material.dart';

void flashbagMessage(
  BuildContext context,
  String message,
  Color backgroundColor,
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    awesomeTopSnackbar(
      context,
      message,
      iconWithDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      backgroundColor: backgroundColor,
    );
  });
}
