
import 'package:flutter/material.dart';
import 'package:myapp/chat_list/chat_model.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: chat.isIcon ? _getAvatarColor() : Colors.transparent,
        child: chat.isIcon
            ? const Icon(Icons.sentiment_satisfied, color: Colors.white, size: 30)
            : ClipOval(
                child: Image.network(
                  chat.avatarUrl,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
      ),
      title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(chat.lastMessage, style: const TextStyle(color: Colors.grey)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(chat.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 5),
          if (chat.unreadCount > 0)
            CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xFF2CB7A6),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Color _getAvatarColor() {
    if (chat.name == 'Adison Rhiel Madsen') {
      return Colors.blue;
    } else if (chat.name == 'Maria Lipshutz') {
      return Colors.green;
    }
    return Colors.blue;
  }
}
