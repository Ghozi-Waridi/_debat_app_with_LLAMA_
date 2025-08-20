import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/domain/repositories/chat_repository.dart';

class SendmessageUsecase {
  final ChatRepository repository;

  SendmessageUsecase({required this.repository});

  Future<ChatEntity> call({
    required String prompt,
    required int sessionId,
  }) async {
    return await repository.sendMessage(prompt: prompt, sessionId: sessionId);
  }
}
