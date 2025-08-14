import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable{
  final String role;
  final String content;

  ChatEntity({
    required this.role,
    required this.content,
  });

  @override
  List<Object?> get props => [role, content];
}