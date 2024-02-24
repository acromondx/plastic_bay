import 'package:flutter/material.dart';
import 'package:plastic_bay/features/leaderboard/widgets/top_contributors_card.dart';
import 'package:plastic_bay/model/waste_contributor.dart';

import '../../../theme/app_color.dart';
import 'dashboard_items.dart';
import 'point_earned.dart';

class DashBoardCard extends StatelessWidget {
  final WasteContributor contributor;
  
  const DashBoardCard({super.key, required this.contributor, });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      PointEarnedCard(pointsRemaining: contributor.earnedPoint.toDouble()),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DashBoardItems(
            title: 'Points Earned',
            isPoints: true,
            points: contributor.earnedPoint + contributor.pointsSpent,
            borderColor: AppColors.secondaryColor,
          ),
          DashBoardItems(
            title: 'Points Spent',
            isPoints: true,
            points: contributor.pointsSpent,
            borderColor: Colors.redAccent,
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DashBoardItems(
            title: 'Total Posts',
           
            points: contributor.totalPost,
            borderColor: AppColors.secondaryColor,
          ),
          DashBoardItems(
            title: 'Pending Posts',
           
            points: contributor.pendingPost,
            borderColor: AppColors.secondaryColor,
          ),
        ],
      ),
      const SizedBox(height: 20),
      Text('Recent Posts', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 20),
    ]);
  }
}
