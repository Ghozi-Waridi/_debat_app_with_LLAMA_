part of 'stt_bloc.dart';

abstract class SttEvent extends Equatable {
  const SttEvent();

  @override
  List<Object> get props => [];
}


class InitializeSttEvent extends SttEvent {}

class StartListeningEvent extends SttEvent {}

class TonggelListeningEvent extends SttEvent {
  final bool isListening;

  const TonggelListeningEvent(this.isListening);

  @override
  List<Object> get props => [isListening];
}

class _ChangeEvent extends SttEvent {
  final SttEntity entity;

  _ChangeEvent(this.entity);

  @override
  List<Object> get props => [entity];
}

 
