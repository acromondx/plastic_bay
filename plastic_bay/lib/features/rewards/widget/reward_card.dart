import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/routes/route_path.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            context.pushNamed(RoutePath.rewardDetails, extra: reward);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(reward.imageUrl),
                    fit: BoxFit.fill,
                  ),
                  border: Border.all(
                      width: 0.2,
                      color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Text(reward.name,
                  style: textTheme.titleMedium!.copyWith(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('♻️${reward.value.toString()}',
                      style: textTheme.titleMedium!.copyWith(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Qty ${reward.quantity.toString()}',
                      style: textTheme.titleMedium!.copyWith(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
