import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/theme/app_color.dart';

import '../controller/reward_controller.dart';

class CheckOutCard extends ConsumerStatefulWidget {
  final Reward reward;
  const CheckOutCard({super.key, required this.reward});

  @override
  ConsumerState<CheckOutCard> createState() => _CheckOutCardState();
}

class _CheckOutCardState extends ConsumerState<CheckOutCard> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final reward = widget.reward;
    final rewardController = ref.watch(rewardControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondaryColor,
            )),
        child: Column(
          children: [
            ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(reward.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                title: Text(
                  reward.name,
                  style: textTheme.titleMedium!.copyWith(fontSize: 14),
                ),
                trailing: IconButton(
                    onPressed: () => rewardController.removeFromCart(ref: ref, cartId: reward.id),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))),
            ListTile(
                title: Text(
                  'Total: ♻️${reward.quantity * reward.value}',
                  style: textTheme.titleMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => rewardController.updateCheckOutItem(
                          ref: ref, reward: reward, isAdd: false),
                      icon: const Icon(
                        Icons.remove,
                      ),
                    ),
                    Text(
                      reward.quantity.toString(),
                      style: textTheme.titleMedium!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => rewardController.updateCheckOutItem(
                          ref: ref, reward: reward, isAdd: true),
                      icon: const Icon(
                        Icons.add,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
