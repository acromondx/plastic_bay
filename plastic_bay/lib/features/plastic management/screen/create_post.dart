import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/features/plastic%20management/widgets/image_skeleton.dart';

import '../widgets/post_text_field.dart';

class CreatePost extends HookConsumerWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descriptionController = useTextEditingController();
    final quantityController = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                PostTextField(
                  hintText: 'Description',
                  controller: descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                PostTextField(
                  hintText: 'Quantity e.g 0.5Kg',
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageSkeleton(),
                    ImageSkeleton(),
                    ImageSkeleton(),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Create Post',
                      style: textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
