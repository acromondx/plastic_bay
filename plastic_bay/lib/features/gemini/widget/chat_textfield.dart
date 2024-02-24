import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_color.dart';
import '../controller/gemini_controller.dart';

class ChatTextField extends ConsumerWidget {
  final String hintText;
  final Function() onSubmit;
  final TextEditingController controller;

  const ChatTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gemini = ref.watch(geminiControllerProvider);
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onSubmit,
          icon: gemini
              ? const CircularProgressIndicator()
              : const Icon(
                  Icons.send,
                  color: AppColors.primaryColor,
                ),
        ),
        fillColor: Colors.grey.shade100,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 15,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
