import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/features/plastic%20management/controller/plastic_management_controller.dart';
import 'package:plastic_bay/features/plastic%20management/widgets/dashboard_card.dart';
import 'package:plastic_bay/utils/loading_alert.dart';

import '../../../theme/app_color.dart';
import '../../user_management/controller/user_management_controller.dart';
import '../widgets/dashboard_items.dart';
import '../widgets/point_earned.dart';
import '../widgets/post_card.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentContributor = ref.watch(contributorProfileDetailsProvider);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: currentContributor.when(
        data: (contributor) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ref.watch(myPlasticPostFutureProvider).when(
                  data: (posts) {
                    return ListView.builder(
                        itemCount: posts.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return DashBoardCard(contributor: contributor);
                          }
                          final post = posts[index - 1];
                          return PlasticPostCard(plastic: post);
                        });
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => const LoadingIndicator()));
        },
        error: (error, stackTrace) => Center(child: Text(stackTrace.toString())),
        loading: () => const LoadingIndicator(),
      ),
    ));
  }
}
