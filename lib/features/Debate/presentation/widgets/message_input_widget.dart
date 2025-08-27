import 'package:debate_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class MessageInputWidget extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback sendMessage;
  final bool isListening;
  final VoidCallback onMicPressed;

  const MessageInputWidget({
    super.key,
    required this.textController,
    required this.sendMessage,
    required this.isListening,
    required this.onMicPressed,
  });

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
      decoration: BoxDecoration(
        color: AppColor.background,
        border: Border(top: BorderSide(color: AppColor.accent)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: widget.onMicPressed,

              icon: Icon(
                Icons.mic,
                color: widget.isListening ? Colors.amber : Colors.white,
              ),
            ),
            Expanded(
              child: TextField(
                controller: widget.textController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  hintText: 'Ketik Argument Anda...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: AppColor.accent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => widget.sendMessage,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColor.purpleLight,
              ),
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: widget.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
