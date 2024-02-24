import 'package:flutter/material.dart';
import 'package:plastic_bay/model/gemini_chat.dart';
import 'package:plastic_bay/theme/app_color.dart';

class MessageCard extends StatelessWidget {
  final GeminiAIChat geminiAIChat;
  const MessageCard({super.key, required this.geminiAIChat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          geminiAIChat.isGemini ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: geminiAIChat.isGemini
                ? AppColors.primaryColor.withOpacity(0.1)
                : AppColors.secondaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            geminiAIChat.message,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
