import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/providers.dart';
import '../features/user_management/controller/user_management_controller.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contributorProfileDetails =
        ref.watch(contributorProfileDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: ref.watch(authApiProvider).authStateChanges != null
            ? Colors.green
            : Colors.red,
      ),
      body: contributorProfileDetails.when(
          data: (contributor) {
            return Column(
              children: [
                Image.network(contributor.pictureUrl),
                Text('Name: ${contributor.name}'),
                Text(contributor.email),
                Text('Current Point: ${contributor.earnedPoint.toString()}'),
                Text(
                    'Total Points spent: ${contributor.pointsSpent.toString()}'),
              ],
            );
          },
          error: (error, trace) => Center(
                child: Text(error.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
