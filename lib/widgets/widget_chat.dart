import 'package:flutter/material.dart';

import '../components/widget_custom_chat.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0,bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chatIndex == 0)
            CircleAvatar(
              backgroundImage: AssetImage(AssetsManager.botImage),
              radius: 16.0,
            )
          else
            const SizedBox(width: 24.0),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Align(
              alignment:
                  chatIndex != 0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: chatIndex == 0
                      ? const Color(0xff55bb8e)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  msg,
                  style: TextStyle(
                    color: chatIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          if (chatIndex != 0)
            CircleAvatar(
              backgroundImage: AssetImage(AssetsManager.userImage),
              radius: 16.0,
            )
          else
            const SizedBox(width: 24.0),
        ],
      ),
    );
  }
}
