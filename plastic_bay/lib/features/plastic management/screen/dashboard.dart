import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_color.dart';
import '../../user_management/controller/user_management_controller.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/point_earned.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentContributor = ref.watch(contributorProfileDetailsProvider);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: currentContributor.when(
        data: (contributor) {
          return Column(
            children: <Widget>[
              PointEarnedCard(pointsRemaining: contributor.earnedPoint),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashBoardCard(
                    title: 'Points Earned',
                    points: contributor.earnedPoint + contributor.pointsSpent,
                    borderColor: AppColors.secondaryColor,
                  ),
                  DashBoardCard(
                    title: 'Points Spent',
                    points: contributor.pointsSpent,
                    borderColor: Colors.redAccent,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashBoardCard(
                    title: 'Total Posts',
                    points: contributor.totalPost.toDouble(),
                    borderColor: AppColors.secondaryColor,
                  ),
                  DashBoardCard(
                    title: 'Pending Posts',
                    points: contributor.totalPost.toDouble(),
                    borderColor: AppColors.secondaryColor,
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    ));
  }
}
