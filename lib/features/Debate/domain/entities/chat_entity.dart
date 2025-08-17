import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable{
  final String role;
  final String content;
  final int? sessionID;

  ChatEntity({
    required this.role,
    required this.content,
    this.sessionID,
  });

  @override
  List<Object?> get props => [role, content, sessionID];
}
