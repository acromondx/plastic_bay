import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastic_bay/constants/ui/svgs.dart';
import 'package:plastic_bay/theme/app_color.dart';

class SocialSignInButton extends StatelessWidget {
  final bool isGoogle;
  final Function() onPressed;
  const SocialSignInButton({
    super.key,
    required this.isGoogle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          border: Border.all(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(isGoogle ? AppSvg.googleLogo : AppSvg.appleLogo,
                width: 30, height: 30),
            const SizedBox(width: 5),
            Text(isGoogle ? 'Google' : 'Apple',
                style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );
  }
}
