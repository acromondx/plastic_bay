import 'package:flutter/material.dart';
import 'package:plastic_bay/model/waste_contributor.dart';

class ContributorsCard extends StatelessWidget {
  final WasteContributor contributor;
  const ContributorsCard({super.key, required this.contributor});

  @override
  Widget build(BuildContext context) {
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
                title: Text(contributor.name),
                subtitle: Text(contributor.earnedPoint.toString()),
              ),
            ],
          )),
    );
  }
}
