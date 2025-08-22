part of 'debate_bloc.dart';

abstract class DebateState extends Equatable {
  const DebateState();
  @override
  List<Object?> get props => [];
}

class DebateInitial extends DebateState {}

class DebateLoading extends DebateState {}

class DebatLoaded extends DebateState {
  final List<ChatEntity> messages;
  const DebatLoaded({required this.messages});
  @override
  List<Object?> get props => [messages];
}

class DebateError extends DebateState {
  final String message;
  const DebateError({required this.message});
  @override
  List<Object?> get props => [message];
}
