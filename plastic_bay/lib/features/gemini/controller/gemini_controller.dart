import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:plastic_bay/model/gemini_chat.dart';

final geminiControllerProvider =
    StateNotifierProvider<GeminiController, bool>((ref) {
  return GeminiController();
});
final chatHistoryProvider =
    StateNotifierProvider<ChatHistoryController, List<GeminiAIChat>>((ref) {
  return ChatHistoryController();
});


class ChatHistoryController extends StateNotifier<List<GeminiAIChat>> {
  ChatHistoryController(): super([]);
  
  void addChat(GeminiAIChat chat){
    state = [...state, chat];
  }
  
}

class GeminiController extends StateNotifier<bool> {
  GeminiController() : super(false);
  Future<GeminiAIChat> generateResponse({required String prompt}) async {
    state = true;
    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: 'AIzaSyDbHqJso2JFqlRuLrOVsy9MvNAASkL94n0');
    final content = [
      Content.text('This question is about plastics waste. $prompt')
    ];
    try {
      final response = await model
          .generateContent(content)
          .timeout(const Duration(seconds: 30));
      state = false;
      return GeminiAIChat(isGemini: true, message: response.text!);
    } catch (e) {
      state = false;
      return GeminiAIChat(
          isGemini: true,
          message:
              'I am sorry, I am unable to process your request at the moment');
    }
  }
}
