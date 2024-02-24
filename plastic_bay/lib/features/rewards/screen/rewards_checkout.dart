import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/features/rewards/widget/check_out_card.dart';
import 'package:plastic_bay/features/user_management/controller/user_management_controller.dart';
import 'package:plastic_bay/theme/app_color.dart';
import 'package:plastic_bay/utils/loading_alert.dart';
import 'package:plastic_bay/utils/toast_message.dart';

import '../../../api/local_database/isar_service.dart';
import '../controller/reward_controller.dart';

class RewardsCheckOut extends ConsumerStatefulWidget {
  const RewardsCheckOut({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardsCheckOutState();
}

class _RewardsCheckOutState extends ConsumerState<RewardsCheckOut> {
  double totalCost = 0;
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartFutureProvider);
    final rewardController = ref.watch(rewardControllerProvider.notifier);
    final rewardControllerState = ref.watch(rewardControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards CheckOut'),
      ),
      bottomNavigationBar: rewardControllerState
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final contributor =
                      ref.read(contributorProfileDetailsProvider).value!;
                  if (totalCost >
                      (contributor.earnedPoint - contributor.pointsSpent)) {
                    showToastMessage('You do not have enough points', context);
                  } else {
                    rewardController.redeemReward(
                        rewards: cartList.value!, context: context, ref: ref);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Redeem now ',
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: cartList.when(
                          data: (cartList) {
                            double total = 0;
                            for (final cart in cartList) {
                              total += cart.quantity * cart.value;
                            }
                            totalCost = total;
                            return Text(
                              '♻︎ $total',
                              style: textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: AppColors.greyColor,
                              ),
                            );
                          },
                          error: (error, stackTrace) => Center(
                                child: Text(error.toString()),
                              ),
                          loading: () => const LoadingIndicator()),
                    )
                  ],
                ),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: rewardControllerState
            ? const LoadingIndicator()
            : cartList.when(
                data: (carts) {
                  return carts.isEmpty
                      ? const Center(
                          child: Text('No reward added'),
                        )
                      : ListView.builder(
                          itemCount: carts.length,
                          itemBuilder: (context, index) {
                            return CheckOutCard(reward: carts[index]);
                          });
                },
                error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                loading: () => const LoadingIndicator()),
      ),
    );
  }
}
