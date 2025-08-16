import 'package:debate_app/core/config/api_config.dart';
import 'package:debate_app/features/Topics/data/models/topic_model.dart';
import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';
import 'package:dio/dio.dart';

abstract class TopicDatasource {
  Future<List<TopicEntity>> getTopics();
}

class TopicDatasourceImpl implements TopicDatasource {
  final Dio dio;
  TopicDatasourceImpl({required this.dio});
  @override
  Future<List<TopicModel>> getTopics() async {
    try {
      final response = await dio.get(ApiConfig.topicsEndpoint);
      if (response.statusCode == 200) {
        return TopicModel.fromJsonList(response.data);
      } else {
        throw Exception("Gagal mendapatkan data topik");
      }
    } catch (e) {
      throw Exception("Error fetching topics: $e");
    }
  }
}
