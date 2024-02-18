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
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(contributor.pictureUrl),
                ),
                title: Text(
                  contributor.name,
                  style: textTheme.bodyMedium,
                ),
                trailing: Text(
                  contributor.earnedPoint.toString(),
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