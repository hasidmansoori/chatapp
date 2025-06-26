import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../core/utils/helpers.dart';

class ChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.find();
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Obx(() => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            reverse: true, // show newest message at bottom
            itemCount: c.messages.length,
            itemBuilder: (_, i) {
              final m = c.messages[c.messages.length - 1 - i]; // reverse list for reverse:true
              final isMe = m.senderId == c.currentUserId;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blueAccent.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isMe ? 18 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.message,
                        style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        Helpers.formatDate(DateTime.parse(m.timestamp)),
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: c.messageController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey.shade200,
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: c.sendMessage,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
