import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/ui/svgs.dart';
import '../../../theme/app_color.dart';

class CustomAuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPasswordField;
  final String leadingSvg;

  const CustomAuthField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPasswordField = false,
    required this.leadingSvg,
  }) : super(key: key);

  @override
  State<CustomAuthField> createState() => _CustomAuthFieldState();
}

class _CustomAuthFieldState extends State<CustomAuthField> {
  bool showObscureText = true;
  String? _errorMessage;

  void showHidePassword() {
    setState(() {
      showObscureText = !showObscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: widget.isPasswordField ? showObscureText : false,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(
                12.0), // Adjust padding to position the SVG
            child: SvgPicture.asset(
              widget.leadingSvg,
              width: 24, // Adjust width
              height: 24, // Adjust height
              fit: BoxFit.contain,
              color: AppColors.secondaryColor,
            ),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  splashColor: Colors.transparent,
                  onPressed: showHidePassword,
                  icon: SizedBox(
                    width: 24, // Adjust width
                    height: 24, // Adjust height
                    child: SvgPicture.asset(
                        showObscureText ? AppSvg.eyeSlashBold : AppSvg.eyeBold,
                        fit: BoxFit.contain,
                        color: AppColors.secondaryColor),
                  ))
              : const SizedBox(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          errorText: _errorMessage,
        ),
      ),
    );
  }
}
