import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastic_bay/theme/app_color.dart';

class CustomIcon extends StatelessWidget {
  final String assetName;
  final bool isActive;
  const CustomIcon(
      {super.key, required this.assetName, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      color: isActive ? AppColors.primaryColor : Colors.black,
      width: 25,
      height: 25,
    );
  }
}