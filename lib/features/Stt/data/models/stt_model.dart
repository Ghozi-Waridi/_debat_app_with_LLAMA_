import 'package:debate_app/features/Stt/domain/entities/stt_entity.dart';

class SttModel extends SttEntity {
  SttModel({required super.text, required super.speechEnable, required super.isStoped, required super.infoText});
  factory SttModel.initial() {
    return SttModel(
      text: '',
      speechEnable: false,
      isStoped: true,
      infoText: '',
    );
  }


  SttModel copyWith({String? text, bool? speechEnable, bool? isStoped, String? infoText }) {
    return SttModel(
      text: text ?? this.text,
      speechEnable: speechEnable ?? this.speechEnable,
      isStoped: isStoped ?? this.isStoped,
      infoText: infoText ?? this.infoText,
    );
  }


  
}