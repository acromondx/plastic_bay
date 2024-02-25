import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:plastic_bay/theme/app_color.dart';

showToastMessage(String message, BuildContext context,
    {bool isSuccess = false}) {
  return showToast(message,
      context: context,
      curve: Curves.linear,
      duration: const Duration(seconds: 4),
      position: StyledToastPosition.bottom,
      animDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(10),
      backgroundColor: isSuccess ? AppColors.primaryColor : Colors.red,
      textStyle: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(color: Colors.white));
}
