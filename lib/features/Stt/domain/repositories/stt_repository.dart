import 'package:debate_app/features/Stt/domain/entities/stt_entity.dart';

abstract class SttRepository {
  Future<bool> initSpeechToText();
  void startListening();
  void stopListening();
  Stream<SttEntity> get onResult;
}