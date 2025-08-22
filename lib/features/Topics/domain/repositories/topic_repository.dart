import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';

abstract class TopicRepository {
  Future<List<TopicEntity>> getTopics();
}
