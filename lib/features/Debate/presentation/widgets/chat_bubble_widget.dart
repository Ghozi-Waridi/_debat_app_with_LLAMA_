import 'package:debate_app/core/theme/color.dart';
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
          color: isUserMessage ? AppColor.purpleLight : AppColor.accent,
          borderRadius: BorderRadius.only(
            topLeft: isUserMessage ? const Radius.circular(30) : Radius.zero,
            topRight: isUserMessage ? Radius.zero : const Radius.circular(30),
            bottomLeft: const Radius.circular(30),
            bottomRight: const Radius.circular(30),
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
