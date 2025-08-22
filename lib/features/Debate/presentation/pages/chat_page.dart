import 'package:debate_app/core/theme/color.dart';
import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:debate_app/features/Debate/presentation/widgets/chat_bubble_widget.dart';
import 'package:debate_app/features/Debate/presentation/widgets/message_input_widget.dart';
import 'package:debate_app/features/Debate/presentation/widgets/typing_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String topic;
  final String role; // Pro/Kontra

  const ChatPage({super.key, required this.topic, required this.role});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  int _lastItemCount = 0;

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;

    final bloc = context.read<DebateBloc>();
    if (bloc.currentSessionId == 0) {
      bloc.add(
        CreateSessionEvent(
          prompt: text,
          topic: widget.topic,
          role: widget.role,
        ),
      );
    } else {
      bloc.add(SendMessageEvent(text));
    }
    _textCtrl.clear();
  }

  void _scrollToBottom({bool animated = true}) {
    if (!_scrollCtrl.hasClients) return;
    final offset = _scrollCtrl.position.maxScrollExtent + 80;
    if (animated) {
      _scrollCtrl.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _scrollCtrl.jumpTo(offset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const Text("Debate Room", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future<void>.delayed(const Duration(milliseconds: 16));
            if (context.mounted) Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<DebateBloc, DebateState>(
              listener: (context, state) {
                final bloc = context.read<DebateBloc>();
                final hasTyping = state is DebateLoading;
                final currentCount = bloc.messages.length + (hasTyping ? 1 : 0);

                final increased = currentCount > _lastItemCount;
                _lastItemCount = currentCount;

                if (increased) {
                  // Scroll setelah frame berikutnya biar ListView sudah punya ukuran final
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom(animated: true);
                  });
                }
              },
              builder: (context, state) {
                final bloc = context.read<DebateBloc>();
                final isTyping = state is DebateLoading;

                // Ambil pesan + tambahkan typing bubble saat loading
                final items = List<ChatEntity>.from(bloc.messages);
                if (isTyping) {
                  items.add(
                    ChatEntity(
                      role: 'assistant',
                      content: '__typing__',
                      sessionId: bloc.currentSessionId,
                    ),
                  );
                }

                if (state is DebateError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is DebatLoaded || state is DebateLoading) {
                  return ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final m = items[i];
                      if (m.role != 'user' && m.content == '__typing__') {
                        return const TypingBubble();
                      }
                      return ChatBubbleWidget(message: m);
                    },
                  );
                }

                // Initial state
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          MessageInputWidget(
            textController: _textCtrl,
            sendMessage: _handleSend,
          ),
        ],
      ),
    );
  }
}
