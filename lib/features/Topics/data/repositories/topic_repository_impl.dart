import 'package:debate_app/features/Topics/data/datasources/topic_datasource.dart';
import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';
import 'package:debate_app/features/Topics/domain/repositories/topic_repository.dart';

class TopicRepositoryImpl implements TopicRepository {
  final TopicDatasource topicDatasource;
  TopicRepositoryImpl({required this.topicDatasource});
  @override
  Future<List<TopicEntity>> getTopics() async {
    try {
      final result = await topicDatasource.getTopics();
      return result;
    } catch (e) {
      throw Exception("Repository error: ${e.toString()}");
    }
  }
}
