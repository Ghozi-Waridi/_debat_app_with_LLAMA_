import 'package:debate_app/features/Stt/domain/repositories/stt_repository.dart';

class StoplisteningUsecase {
  final SttRepository repository;

  StoplisteningUsecase(this.repository);

  void call() {
    repository.stopListening();
  }
}
