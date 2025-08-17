import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';

abstract class CahtRepository {
  Future<ChatEntity> sendMessage({
    required String prompt,
    String? topic,
    String? pihak,
    int? sessionId,
  });
}