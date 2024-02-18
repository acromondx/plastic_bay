import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text('View Post'),
            ElevatedButton(
              onPressed: () {
                //ref.read(postProvider.notifier).deletePost();
               /// Navigator.pop(context);
              },
              child: const Text('Delete Post'),
            )
          ],
        ),
      )
    );
  }
}