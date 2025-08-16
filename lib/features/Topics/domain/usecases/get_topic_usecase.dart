import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';
import 'package:debate_app/features/Topics/domain/repositories/topic_repository.dart';

class GetTopicUsecase {
  final TopicRepository repository;

  GetTopicUsecase({required this.repository});

  Future<List<TopicEntity>> call() {
    return repository.getTopics();
  }
}
