import 'package:equatable/equatable.dart';

class TopicEntity extends Equatable {
  final int id;
  final String topic;

  const TopicEntity({required this.id, required this.topic});

  @override
  List<Object?> get props => [id, topic];
}
