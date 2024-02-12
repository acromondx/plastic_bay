import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/providers.dart';
import '../features/leaderboard/controller/leader_board_controller.dart';

class TopContributors extends ConsumerWidget {
  const TopContributors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topContributors = ref.watch(topContributorsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Contributors'),
        backgroundColor: ref.watch(authApiProvider).authStateChanges != null
            ? Colors.green
            : Colors.red,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: topContributors.when(
              data: (contributors) {
                return ListView.builder(
                  itemCount: contributors.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(contributors[index].name),
                          subtitle: Text(contributors[index].email),
                        ),
                        Image.network(contributors[index].pictureUrl),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                                'Total Post: ${contributors[index].totalPost}'),
                            const SizedBox(width: 10),
                            Text(
                                'Total Point: ${contributors[index].earnedPoint}'),
                          ],
                        )
                      ],
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
