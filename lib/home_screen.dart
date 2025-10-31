
import 'package:flutter/material.dart';
import 'package:myapp/chat_message.dart';
import 'package:myapp/message_buble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [
    const ChatMessage(
      message: 'Hola, ¿cómo estás?',
      isMe: true,
    ),
    const ChatMessage(
      message: '¡Hola! Estoy bien, ¿y tú?',
      isMe: false,
    ),
    const ChatMessage(
      message: 'Necesito ayuda con mi cuenta.',
      isMe: true,
    ),
    const ChatMessage(
      message: 'Claro, ¿cuál es el problema?',
      isMe: false,
    ),
  ];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          message: text,
          isMe: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0F2F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00796B)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Administrador',
          style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => ChatMessageBubble(
                message: _messages[index].message,
                isMe: _messages[index].isMe,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Escribir...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: () => _handleSubmitted(_textController.text),
                  backgroundColor: const Color(0xFF00796B),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
