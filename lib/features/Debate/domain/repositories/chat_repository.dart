import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<ChatEntity> sendMessage({
    required String prompt,
    required int sessionId,
  });

  Future<Map<String, dynamic>> createSession({
    required String prompt,
    required String topic,
    required String role,
  });
}
