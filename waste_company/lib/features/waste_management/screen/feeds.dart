import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_company/api/providers.dart';
import 'package:waste_company/features/waste_management/widget/post_card.dart';

import '../../../utils/loading_alert.dart';

class Feeds extends ConsumerWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(plasticPostProvider);
    return Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(plasticPostProvider);
        },
        child: post.when(
          skipLoadingOnRefresh: false,
          data: (posts) {
            return posts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'No post found in 24km in your current location.'),
                        TextButton(
                            onPressed: () {
                              ref.invalidate(plasticPostProvider);
                            },
                            child: const Text('Refresh'))
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return PlasticPostCard(plastic: post);
                    });
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const LoadingIndicator(),
        ),
      ),
    );
  }
}
