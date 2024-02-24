import 'package:flutter/material.dart';
import 'package:plastic_bay/theme/app_color.dart';

class PointEarnedCard extends StatelessWidget {
  final double pointsRemaining;
  const PointEarnedCard({super.key, required this.pointsRemaining});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Points Remaining',
              style: textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text('♻️ $pointsRemaining',
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
          ]),
    );
  }
}
