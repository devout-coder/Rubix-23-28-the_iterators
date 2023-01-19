import 'package:flutter/material.dart';

import '../../../../models/commmunitymessage.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    required this.message,
  });
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16 * 0.75, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(message.isSender ? 1 : 0.88),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(message.text,
          style:
              TextStyle(color: message.isSender ? Colors.white : Colors.black)),
    );
  }
}
