import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final bool bold;
  final Color? color;
  final bool formSpacing;

  final double? size;
  const CustomText({
    Key? key,
    required this.text,
    this.bold = false,
    this.formSpacing = false,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    return Padding(
      padding: formSpacing
          ? const EdgeInsets.only(top: 20, bottom: 15)
          : const EdgeInsets.all(0),
      child: Text(text,
          style: txtStyle!.copyWith(
            fontSize: size,
            color: color,
            fontWeight: bold ? FontWeight.bold : null,
          )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enableMaxlines;
  final bool editable;
  final IconData? suffixIcon;
  final IconData? prefixIcon;

  final TextInputType? inputType;
  final bool? showHintText;
  final String? hintText;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.enableMaxlines = false,
      this.suffixIcon,
      this.prefixIcon,
      this.editable = true,
      this.inputType,
      this.showHintText = false,
      this.hintText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      maxLines: enableMaxlines ? 5 : 1,
      enabled: editable,
     // style: const TextStyle(color: AppColors.secondaryColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon == null
            ? null
            : Icon(suffixIcon, 
          //  color: AppColors.secondaryColor
            ),
        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon, 
           // color: AppColors.secondaryColor
            ),
        filled: true,
        fillColor: editable ? Colors.grey.shade100 : Colors.grey.shade100,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
           // color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        hintText: showHintText! ? hintText : null,
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
