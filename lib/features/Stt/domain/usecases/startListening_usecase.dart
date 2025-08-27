import 'package:debate_app/features/Stt/domain/repositories/stt_repository.dart';

class StartListeningUsecase {
  final SttRepository repository;

  StartListeningUsecase(this.repository);

  void call() {
    repository.startListening();
  }
}
