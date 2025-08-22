import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String role;
  final String content;
  final int? sessionId;

  const ChatEntity({required this.role, required this.content, this.sessionId});

  @override
  List<Object?> get props => [role, content, sessionId];
}
