part of 'stt_bloc.dart';


abstract class SttState extends Equatable {
  const SttState();  

  @override
  List<Object> get props => [];
}
class SttInitial extends SttState {}

class SttLoading extends SttState {}

class SttLoaded extends SttState {
  final SttEntity sttEntity;

  const SttLoaded(this.sttEntity);

  @override
  List<Object> get props => [sttEntity];
}

class SttError extends SttState {
  final String message;

  const SttError(this.message);

  @override
  List<Object> get props => [message];
}
