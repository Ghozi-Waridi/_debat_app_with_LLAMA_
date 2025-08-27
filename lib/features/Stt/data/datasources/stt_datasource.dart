import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract class SttDatasource {
  Future<bool> initSpeechToText();
  void startListening({required Function(SpeechRecognitionResult) onResult});
  void stopListening();
  bool get isListening;

}


class SttDatasourceImpl implements SttDatasource {
  final SpeechToText speechToText;

  SttDatasourceImpl(this.speechToText);

  @override
  Future<bool> initSpeechToText() async {
    return await speechToText.initialize();
  }

  @override
  void startListening({required Function(SpeechRecognitionResult) onResult}) {
    speechToText.listen(
      pauseFor: Duration(minutes: 10),
      localeId: "id_ID",
      onResult: onResult,
    );
  }

  @override
  void stopListening() {
    speechToText.stop();
  }

  @override
  bool get isListening => speechToText.isListening;
}