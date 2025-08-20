import 'package:debate_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class MessageInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback sendMessage;
  const MessageInputWidget({
    super.key,
    required this.textController,
    required this.sendMessage,
  });

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
            Expanded(
              child: TextField(
                controller: textController,
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
                onSubmitted: (_) => sendMessage,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColor.purpleLight,
              ),
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
