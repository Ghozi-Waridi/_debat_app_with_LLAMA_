part of 'debate_bloc.dart';

abstract class DebateEvent extends Equatable {
  const DebateEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends DebateEvent {
  final String prompt;

  const SendMessageEvent(this.prompt);

  @override
  List<Object> get props => [prompt];
}
