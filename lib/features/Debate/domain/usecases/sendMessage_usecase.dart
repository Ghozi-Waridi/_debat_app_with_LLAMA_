import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/domain/repositories/chat_repository.dart';

class SendmessageUsecase {
  final CahtRepository repository;

  SendmessageUsecase({required this.repository});

  Future<ChatEntity> call ({required String prompt, int? sessionId}) async {
    return await repository.sendMessage(prompt: prompt, sessionId: sessionId);
  }
}