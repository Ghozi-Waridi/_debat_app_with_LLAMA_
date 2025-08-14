import 'package:debate_app/features/Debate/domain/entities/chat_entity.dart';
import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatEntity message;
  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isUserMessage = message.role == 'user';
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUserMessage ? const Radius.circular(20) : Radius.zero,
            bottomRight:
                isUserMessage ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isUserMessage ? Colors.white : Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
