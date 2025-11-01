import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/chat_list/chat_list_item.dart';
import 'package:myapp/chat_list/chat_model.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Chat> _chats = [
    Chat(
      avatarUrl: 'https://picsum.photos/id/1005/200/200',
      name: 'Novio',
      lastMessage: 'Esta tendencia moderna se ve bien y...',
      time: '11.23 am',
      unreadCount: 3,
    ),
    Chat(
      avatarUrl: 'smiley_face',
      name: 'Jose hermano',
      lastMessage: 'No has entendido el punto',
      time: '11.23 am',
      unreadCount: 12,
      isIcon: true,
    ),
    Chat(
      avatarUrl: 'https://picsum.photos/id/1011/200/200',
      name: 'Justin Bergson',
      lastMessage: 'Añadir ese poquito de realismo 3D...',
      time: '10.19.2020',
      unreadCount: 1,
    ),
    Chat(
      avatarUrl: 'smiley_face_green',
      name: 'Lau ucc',
      lastMessage: 'Esta tendencia moderna se ve bien y...',
      time: '10.19.2020',
      unreadCount: 0,
      isIcon: true,
    ),
    Chat(
      avatarUrl: 'https://picsum.photos/id/1027/200/200',
      name: 'Desirae Culhane',
      lastMessage: 'No has entendido el punto',
      time: '10.19.2020',
      unreadCount: 0,
    ),
    Chat(
      avatarUrl: 'https://picsum.photos/id/1012/200/200',
      name: 'Gretchen Botosh',
      lastMessage: 'Añadir ese poquito de realismo 3D...',
      time: '10.19.2020',
      unreadCount: 0,
    ),
    Chat(
      avatarUrl: 'https://picsum.photos/id/1025/200/200',
      name: 'Wilson Curtis',
      lastMessage: 'Esta tendencia moderna se ve bien y...',
      time: '10.19.2020',
      unreadCount: 0,
    ),
  ];

  late TextEditingController _searchController;
  List<Chat> _filteredChats = [];

  @override
  void initState() {
    super.initState();
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
        title: const Text(
          'Mensajes',
          style: TextStyle(color: Color(0xFF2CB7A6)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChats.length,
              itemBuilder: (context, index) {
                final chat = _filteredChats[index];
                return GestureDetector(
                  onTap: () => context.go('/chat'),
                  child: ChatListItem(chat: chat),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
