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
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Ketik Argument Anda ...',
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => sendMessage,
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: Colors.blue),
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
