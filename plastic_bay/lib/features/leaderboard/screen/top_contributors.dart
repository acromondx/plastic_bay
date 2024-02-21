import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/leader_board_controller.dart';
import '../widgets/top_contributors_card.dart';

class TopContributors extends ConsumerWidget {
  const TopContributors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topContributors = ref.watch(topContributorsProvider);
    return Scaffold(
      body: topContributors.when(
          data: (contributors) {
            return ListView.builder(
                itemCount: contributors.length,
                itemBuilder: (context, index) {
                  return ContributorsCard(
                    contributor: contributors[index],
                  );
                });
          },
          error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
