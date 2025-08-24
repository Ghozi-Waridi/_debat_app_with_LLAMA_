import 'package:equatable/equatable.dart';

class SttEntity extends Equatable {
  final String text;

  SttEntity({required this.text});

  @override
  List<Object?> get props => [text];
}