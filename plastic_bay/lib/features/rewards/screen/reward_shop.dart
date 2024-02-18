import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/features/rewards/widget/reward_card.dart';
import 'package:plastic_bay/utils/loading_alert.dart';

import '../controller/reward_controller.dart';

class RewardCatalog extends ConsumerWidget {
  const RewardCatalog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardCat = ref.watch(rewardCatalogFutureProvider);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: rewardCat.when(
          data: (rewards) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  return RewardCard(
                    reward: rewards[index],
                  );
                });
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const LoadingIndicator()),
    ));
  }
}
