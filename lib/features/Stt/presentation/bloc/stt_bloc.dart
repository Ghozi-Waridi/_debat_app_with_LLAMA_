import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stt_event.dart';
part 'stt_state.dart';

class SttBloc extends Bloc<SttEvent, SttState> {
  SttBloc() : super(SttInitial()) {
    on<SttEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
