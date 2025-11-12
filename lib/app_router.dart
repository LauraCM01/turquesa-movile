import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/chat_list/chat_list_screen.dart';
import 'chat_screen.dart';
import 'Pantalla-Perfil.dart'; // Asegúrate de que este archivo existe
import 'Pantalla-Inicio.dart'; // Asegúrate de que este archivo existe

final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Home Route
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    // Profile Route
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Chat List Route (Base: /chat)
    GoRoute(
      path: '/chat',
      builder: (BuildContext context, GoRouterState state) {
        return const ChatListScreen();
      },
    ),

    // Individual Chat Route (Child: /chat/:chatId)
    GoRoute(
      path: '/chat/:chatId', // Este camino coincide con el context.go('/chat/${chat.id}')
      builder: (BuildContext context, GoRouterState state) {
        final chatId = state.pathParameters['chatId']!;
        return ChatScreen(chatId: chatId);
      },
    ),
  ],

  // Error handling for not found routes
  errorPageBuilder: (context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(
            'Page Not Found: ${state.error?.message}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  },
);