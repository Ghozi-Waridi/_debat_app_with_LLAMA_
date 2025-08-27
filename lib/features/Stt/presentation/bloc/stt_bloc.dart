import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:debate_app/features/Stt/domain/entities/stt_entity.dart';
import 'package:debate_app/features/Stt/domain/usecases/getSpeeshStream_usecase.dart';
import 'package:debate_app/features/Stt/domain/usecases/initSpeechToText_usecase.dart';
import 'package:debate_app/features/Stt/domain/usecases/startListening_usecase.dart';
import 'package:debate_app/features/Stt/domain/usecases/stopListening_usecase.dart';
import 'package:equatable/equatable.dart';

part 'stt_event.dart';
part 'stt_state.dart';

class SttBloc extends Bloc<SttEvent, SttState> {
  final StartListeningUsecase startListeningUsecase;
  final StoplisteningUsecase stopListeningUsecase;
  final InitspeechtotextUsecase initspeechtotextUsecase;
  final GetspeeshstreamUsecase getspeeshstreamUsecase;

  StreamSubscription? _speechSubscription;

  SttBloc({
    required this.startListeningUsecase,
    required this.initspeechtotextUsecase,
    required this.stopListeningUsecase,
    required this.getspeeshstreamUsecase,
  }) : super(SttInitial()) {
    on<InitializeSttEvent>(_onInitializeSpeech);
    on<TonggelListeningEvent>(_onTonggleListening);
    on<_ChangeEvent>(_onSpeechStatusChanged);

    _getStream();
  }

  void _getStream() {
    _speechSubscription = getspeeshstreamUsecase().listen((entity) {
      add(_ChangeEvent(entity));
    });
  }

  Future<void> _onInitializeSpeech(
    InitializeSttEvent event,
    Emitter<SttState> emit,
  ) async {
    emit(SttLoading());
    final isInitialized = await initspeechtotextUsecase();
    print("Hasil Inisialisasi : ${isInitialized}");

    if (isInitialized) {
      emit(
        SttLoaded(
          SttEntity(
            infoText: "Tekan mic untuk berbicara",
            isStoped: true,
            text: "",
            speechEnable: false,
          ),
        ),
      );
    } else {
      emit(SttError("Gagal menginisialisasi Speech-to-Text"));
    }
  }

  void _onTonggleListening(
    TonggelListeningEvent event,
    Emitter<SttState> emit,
  ) {
    if (event.isListening) {
      startListeningUsecase();
    } else {
      stopListeningUsecase();
    }
  }

  void _onSpeechStatusChanged(_ChangeEvent event, Emitter<SttState> emit) {
    emit(SttLoaded(event.entity));
  }

  @override
  Future<void> close() {
    _speechSubscription?.cancel();
    return super.close();
  }
}
