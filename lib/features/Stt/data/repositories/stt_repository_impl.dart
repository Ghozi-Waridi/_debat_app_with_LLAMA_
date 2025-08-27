import 'dart:async';

import 'package:debate_app/features/Stt/data/datasources/stt_datasource.dart';
import 'package:debate_app/features/Stt/domain/entities/stt_entity.dart';
import 'package:debate_app/features/Stt/domain/repositories/stt_repository.dart';

class SttRepositoryImpl implements SttRepository {
  final SttDatasource datasource;
  final _controller = StreamController<SttEntity>.broadcast();
  String _lastWorld = "";

  SttRepositoryImpl({required this.datasource});

  @override
  Future<bool> initSpeechToText() async {
    return await datasource.initSpeechToText();
  }

  @override
  void startListening() {
    _lastWorld = '';
    print("Last World 1 : $_lastWorld");

    // Emit state saat mulai listening
    _controller.add(
      SttEntity(
        text: '',
        isStoped: false,
        speechEnable: true,
        infoText: 'Mendengarkan...',
      ),
    );

    datasource.startListening(
      onResult: (result) {
        _lastWorld = result.recognizedWords;
        print("Last World: $_lastWorld");
        _controller.add(
          SttEntity(
            text: _lastWorld,
            isStoped: !result.finalResult,
            speechEnable: datasource.isListening,
            infoText: result.finalResult ? 'Selesai' : 'Mendengarkan...',
          ),
        );
      },
    );

    print("Last World 2 : $_lastWorld");
  }

  @override
  void stopListening() {
    datasource.stopListening();
    _controller.add(
      SttEntity(
        text: _lastWorld,
        isStoped: true,
        speechEnable: false,
        infoText: 'Tekan mic untuk mulai berbicara',
      ),
    );
  }

  @override
  Stream<SttEntity> get onResult => _controller.stream;
}
