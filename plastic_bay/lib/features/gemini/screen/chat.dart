import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/gemini_chat.dart';
import '../../../utils/toast_message.dart';
import '../controller/gemini_controller.dart';
import '../widget/chat_textfield.dart';
import '../widget/message_card.dart';

class GeminiChat extends ConsumerStatefulWidget {
  const GeminiChat({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GeminiChatState();
}

class _GeminiChatState extends ConsumerState<GeminiChat> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final gemini = ref.watch(geminiControllerProvider.notifier);
    final chatHistory = ref.watch(chatHistoryProvider);
    final chatHistoryAdd = ref.watch(chatHistoryProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ChatTextField(
              hintText: 'Get answers to all your questions here...',
              controller: controller,
              onSubmit: () async {
                String prompt = controller.text;
                controller.clear();
                if (prompt.isNotEmpty) {
                  chatHistoryAdd.addChat(GeminiAIChat(
                    message: prompt,
                    isGemini: false,
                  ));

                  await gemini.generateResponse(prompt: prompt).then((value) {
                    chatHistoryAdd.addChat(value);
                  });
                } else {
                  showToastMessage('Message can not be empty', context);
                }
                prompt = '';
              },
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
            itemCount: chatHistory.length,
            itemBuilder: (context, index) {
              return MessageCard(
                geminiAIChat: chatHistory[index],
              );
            }),
      ),
    );
  }
}
