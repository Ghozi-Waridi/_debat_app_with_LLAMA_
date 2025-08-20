import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({required super.role, required super.content});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(role: json['role'], content: json['content']);
  }

  Map<String, dynamic> toJson() {
    return {'role': role, 'content': content};
  }
}
