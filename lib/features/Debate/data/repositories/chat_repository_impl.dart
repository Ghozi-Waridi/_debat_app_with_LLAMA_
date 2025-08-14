import 'package:debate_app/features/Debate/data/datasources/chat_datasource.dart';
import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements CahtRepository {
  final ChatDatasource datasource;

  ChatRepositoryImpl({required this.datasource});

  @override
  Future<ChatEntity> sendMessage({
    required String prompt,
    int? sessionId,
  }) async {
    try {
      final response = await datasource.sendMessage(
        prompt: prompt,
        sessionId: sessionId,
      );

      if (response.containsKey("response")) {
        final aiResponse = ChatEntity(
          role: 'assistant',
          content: response["response"],
        );
        return aiResponse;
      } else {
        throw Exception("Response tidak mengandung kunci 'response'");
      }
    } catch (e) {
      throw Exception("Gagal mengirim pesan: ${e}");
    }
  }
}
