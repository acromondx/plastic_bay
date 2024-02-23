import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class TotalPickUpsCard extends StatelessWidget {
  final int pickups;
  const TotalPickUpsCard({super.key, required this.pickups});

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
              'Total Pickups',
              style: textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(pickups.toString(),
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
          ]),
    );
  }
}
