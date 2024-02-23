
import 'package:flutter/material.dart';
import 'package:waste_company/model/analytics.dart';

import '../../../theme/app_color.dart';
import 'dashboard_item.dart';
import 'total_pick_up_card.dart';

class DashBoardCard extends StatelessWidget {
  final Analytics analytics;
  const DashBoardCard({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TotalPickUpsCard(pickups: analytics.pickedUpPost),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DashBoardItems(
            title: 'Accepted Posts',
            points: analytics.acceptedPost,
            borderColor: AppColors.secondaryColor,
          ),
          DashBoardItems(
            title: 'Points Given',
            points: analytics.pointsGiven,
            borderColor: Colors.redAccent,
          ),
        ],
      ),
      const SizedBox(height: 20),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     DashBoardItems(
      //       title: 'Total Posts',
           
      //       points: contributor.totalPost,
      //       borderColor: AppColors.secondaryColor,
      //     ),
      //     DashBoardItems(
      //       title: 'Pending Posts',
           
      //       points: contributor.pendingPost,
      //       borderColor: AppColors.secondaryColor,
      //     ),
      //   ],
      // ),
      const SizedBox(height: 20),
 
    ]);
  }
}
