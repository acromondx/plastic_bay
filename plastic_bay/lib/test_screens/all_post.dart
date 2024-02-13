import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/providers.dart';
import '../features/plastic management/controller/plastic_management_controller.dart';

class AllPost extends ConsumerWidget {
  const AllPost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPost = ref.watch(myPlasticPostFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ref.watch(authApiProvider).authStateChanges != null
            ? Colors.green
            : Colors.red,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: myPost.when(
              data: (posts) {
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                  
                    return Column(
                      children: [
                        ListTile(
                          title: Text(posts[index].description),
                          subtitle: Text(posts[index].plasticType.toString()),
                        ),
                        Image.network(posts[index].imageUrl),
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
