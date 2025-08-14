import 'package:bloc/bloc.dart';
import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/domain/usecases/sendMessage_usecase.dart';
import 'package:equatable/equatable.dart';

part 'debate_event.dart';
part 'debate_state.dart';

class DebateBloc extends Bloc<DebateEvent, DebateState> {
  final SendmessageUsecase sendMessage;
  int? currentSessionId;
  List<ChatEntity> messages = [];

  DebateBloc({required this.sendMessage}) : super(DebateInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(DebateLoading());
      final userMessage = ChatEntity(role: 'user', content: event.prompt);
      messages.add(userMessage);

      try{
        final aiMessage = await sendMessage(
          prompt: event.prompt,
          sessionId: currentSessionId,
        );
        messages.add(aiMessage);

        emit(DebatLoaded(messages: List.from(messages)));
      } catch (e) {
        emit(DebateError(message: e.toString()));
      }
    });
  }
}
