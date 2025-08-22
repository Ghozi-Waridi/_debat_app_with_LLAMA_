part of 'debate_bloc.dart';

abstract class DebateEvent extends Equatable {
  const DebateEvent();
  @override
  List<Object?> get props => [];
}

class CreateSessionEvent extends DebateEvent {
  final String prompt;
  final String topic;
  final String role; // Pro/Kontra

  const CreateSessionEvent({
    required this.prompt,
    required this.topic,
    required this.role,
  });

  @override
  List<Object?> get props => [prompt, topic, role];
}

class SendMessageEvent extends DebateEvent {
  final String prompt;
  const SendMessageEvent(this.prompt);
  @override
  List<Object?> get props => [prompt];
}
