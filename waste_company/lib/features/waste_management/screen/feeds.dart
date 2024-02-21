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
      child: post.when(
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
            return PlasticPostCard(plastic: posts[index]);
          });
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const LoadingIndicator(),
      ),
    );
  }
}
