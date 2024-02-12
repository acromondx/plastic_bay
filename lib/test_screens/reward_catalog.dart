import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/providers.dart';
import '../features/leaderboard/controller/leader_board_controller.dart';
import '../features/rewards/controller/reward_controller.dart';

class RewardCatalog extends ConsumerWidget {
  const RewardCatalog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardProvider = ref.watch(rewardCatalogFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reward Catalog'),
        backgroundColor: ref.watch(authApiProvider).authStateChanges != null
            ? Colors.green
            : Colors.red,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: rewardProvider.when(
              data: (rewards) {
                return ListView.builder(
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(rewardControllerProvider.notifier)
                            .redeemReward(
                                reward: rewards[index].copyWith(quantity: 2));
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(rewards[index].name),
                            subtitle: Text(rewards[index].description),
                          ),
                          Image.network(rewards[index].imageUrl),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                  'Total Quantity: ${rewards[index].quantity}'),
                              const SizedBox(width: 10),
                              Text('Price ⩒: ${rewards[index].value}'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, t) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }
}
