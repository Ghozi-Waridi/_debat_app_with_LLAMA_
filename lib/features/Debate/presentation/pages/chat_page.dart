import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:debate_app/features/Debate/presentation/widgets/chat_bubble_widget.dart';
import 'package:debate_app/features/Debate/presentation/widgets/message_input_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_textController.text.trim().isNotEmpty) {
      context.read<DebateBloc>().add(
        SendMessageEvent(_textController.text.trim()),
      );
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<DebateBloc, DebateState>(
              listener: (context, state) {
                if (state is DebatLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _scrollToBottom(),
                  );
                } else if (state is DebateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is DebateError) {
                  return const Center(
                    child: Text("Mulai debat dengan tekan Voice"),
                  );
                }
                final messages = context.watch<DebateBloc>().messages;
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: messages.length + (state is DebateLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state is DebateLoading && index == messages.length) {
                      return ChatBubbleWidget(
                        message: ChatEntity(role: "assistant", content: "..."),
                      );
                    }

                    return ChatBubbleWidget(message: messages[index]);
                  },
                );
              },
            ),
          ),
          MessageInputWidget(
            textController: _textController,
            sendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }
}

