import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class DashBoardItems extends StatelessWidget {
  final String title;
  final num points;
  final Color borderColor;
 
  const DashBoardItems({
    super.key,
    required this.title,
    required this.points,
    required this.borderColor,
    
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: textTheme.titleLarge!.copyWith(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(points.toString(),
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
          ]),
    );
  }
}
