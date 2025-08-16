import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';

class TopicModel extends TopicEntity {
  const TopicModel({required super.id, required super.topic});

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(id: json['id'], topic: json['topic']);
  }

  static List<TopicModel> fromJsonList(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((data) => TopicModel.fromJson(data)).toList();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'topic': topic};
  }
}
