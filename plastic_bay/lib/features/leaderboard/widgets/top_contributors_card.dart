import 'package:flutter/material.dart';
import 'package:plastic_bay/model/waste_contributor.dart';
import 'package:plastic_bay/theme/app_color.dart';

class ContributorsCard extends StatelessWidget {
  final WasteContributor contributor;
  const ContributorsCard({super.key, required this.contributor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(contributor.pictureUrl),
                ),
                title: Text(
                  contributor.name,
                  style: textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'Total Points',
                      style: textTheme.titleMedium!.copyWith(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '♻️${contributor.earnedPoint + contributor.pointsSpent}',
                      style: textTheme.titleMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  contributor.totalPost == 0
                      ? '${contributor.totalPost} post'
                      : contributor.totalPost == 1
                          ? '${contributor.totalPost} post'
                          : '${contributor.totalPost} posts',
                  style: textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
