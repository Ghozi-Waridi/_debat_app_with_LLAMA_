import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/domain/usecases/create_session_usecase.dart';
import 'package:debate_app/features/Debate/domain/usecases/send_message_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'debate_event.dart';
part 'debate_state.dart';

class DebateBloc extends Bloc<DebateEvent, DebateState> {
  final SendmessageUsecase sendMessage;
  final CreateSessionUsecase createSession;

  int currentSessionId = 0;
  List<ChatEntity> messages = [];

  DebateBloc({required this.sendMessage, required this.createSession})
    : super(DebateInitial()) {
    on<CreateSessionEvent>(_onCreateSession);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onCreateSession(
    CreateSessionEvent event,
    Emitter<DebateState> emit,
  ) async {
    messages = [];
    currentSessionId = 0;

    final userMsg = ChatEntity(
      role: 'user',
      content: event.prompt,
      sessionId: null,
    );
    messages.add(userMsg);
    emit(DebatLoaded(messages: List.from(messages)));

    try {
      emit(DebateLoading());
      final res = await createSession(
        prompt: event.prompt,
        topic: event.topic,
        role: event.role,
      );

      final sidRaw = res["session_id"];
      final respRaw = res["response"];

      if (sidRaw is! int) {
        throw Exception("session_id tidak valid");
      }
      if (respRaw == null) {
        throw Exception("response kosong");
      }

      currentSessionId = sidRaw;

      final aiMsg = ChatEntity(
        role: 'assistant',
        content: respRaw.toString(),
        sessionId: currentSessionId,
      );
      messages.add(aiMsg);
      emit(DebatLoaded(messages: List.from(messages)));
    } catch (e) {
      emit(DebateError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<DebateState> emit,
  ) async {
    if (currentSessionId == 0) {
      emit(
        const DebateError(
          message: "Sesi belum dibuat. Kirim pesan pertama untuk memulai.",
        ),
      );
      return;
    }

    final userMsg = ChatEntity(
      role: 'user',
      content: event.prompt,
      sessionId: currentSessionId,
    );
    messages.add(userMsg);
    emit(DebatLoaded(messages: List.from(messages)));

    try {
      emit(DebateLoading());
      final aiMsg = await sendMessage(
        prompt: event.prompt,
        sessionId: currentSessionId,
      );
      messages.add(aiMsg);
      emit(DebatLoaded(messages: List.from(messages)));
    } catch (e) {
      emit(DebateError(message: e.toString()));
    }
  }
}
