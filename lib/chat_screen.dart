import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/chat_message.dart';
import 'package:myapp/message_buble.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [
    const ChatMessage(message: 'Hola, ¿cómo estás?', isMe: true),
    const ChatMessage(message: '¡Hola! Estoy bien, ¿y tú?', isMe: false),
    const ChatMessage(message: 'Necesito ayuda con mi cuenta.', isMe: true),
    const ChatMessage(message: 'Claro, ¿cuál es el problema?', isMe: false),
  ];

  @override
  void initState() {
    super.initState();
    print('Cargando mensajes para el chat ID: ${widget.chatId}');
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(message: text, isMe: true));
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.insert(
              0,
              const ChatMessage(
                  message: 'Gracias por tu mensaje. Lo revisaremos.',
                  isMe: false));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String displayChatName = 'Chat con ${widget.chatId.substring(0, 8)}...';

    // Re-added Scaffold to make this screen independent
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2CB7A6)),
          // This now explicitly navigates to the chat list screen
          onPressed: () => context.go('/chat'),
        ),
        title: Text(
          displayChatName,
          style: GoogleFonts.poppins(
            color: const Color(0xFF2CB7A6),
            fontWeight: FontWeight.bold,
          ),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                      onSubmitted: _handleSubmitted,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: () => _handleSubmitted(_textController.text),
                    backgroundColor: const Color(0xFF2CB7A6),
                    elevation: 0,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Notice there is NO bottomNavigationBar here
    );
  }
}
