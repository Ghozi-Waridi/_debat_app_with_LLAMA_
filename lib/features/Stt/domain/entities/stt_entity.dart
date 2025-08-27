import 'package:equatable/equatable.dart';


class SttEntity extends Equatable {
  final String text;
  final bool speechEnable;
  final bool isStoped;
  final String infoText;

  const SttEntity({required this.text, required this.isStoped, required this.speechEnable, required this.infoText});

  @override
  List<Object?> get props => [text, speechEnable, isStoped, infoText];
}