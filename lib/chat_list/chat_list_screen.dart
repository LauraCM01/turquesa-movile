import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/chat_list/chat_list_item.dart';
import 'package:myapp/chat_list/chat_model.dart';
import 'package:myapp/widgets/Barra-Navegacion.dart';
import 'package:uuid/uuid.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final List<Chat> _chats;
  late TextEditingController _searchController;
  List<Chat> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    const uuid = Uuid();
    _chats = [
      Chat(
        id: uuid.v4(),
        avatarUrl: 'https://picsum.photos/id/1005/200/200',
        name: 'Novio',
        lastMessage: 'Esta tendencia moderna se ve bien y...',
        time: '11.23 am',
        unreadCount: 3,
      ),
      Chat(
        id: uuid.v4(),
        avatarUrl: 'smiley_face',
        name: 'Jose hermano',
        lastMessage: 'No has entendido el punto',
        time: '11.23 am',
        unreadCount: 12,
        isIcon: true,
      ),
      Chat(
        id: uuid.v4(),
        avatarUrl: 'https://picsum.photos/id/1011/200/200',
        name: 'Justin Bergson',
        lastMessage: 'Añadir ese poquito de realismo 3D...',
        time: '10.19.2020',
        unreadCount: 1,
      ),
    ];

    _searchController = TextEditingController();
    _filteredChats = _chats;
    _searchController.addListener(_filterChats);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterChats() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChats = _chats.where((chat) {
        return chat.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        toolbarHeight: 80.0,
        title: Text(
          'Chat',
          style: GoogleFonts.poppins(
            color: const Color(0xFF2CB7A6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar chat...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChats.length,
              itemBuilder: (context, index) {
                final chat = _filteredChats[index];
                return InkWell(
                  // *** CORREGIDO: Usar '/chat/' en singular ***
                  onTap: () => context.go('/chat/${chat.id}'),
                  child: ChatListItem(chat: chat),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BarraNavegacion(selectedIndex: 0),
    );
  }
}