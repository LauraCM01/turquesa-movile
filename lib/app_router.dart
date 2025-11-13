import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/chat_list/chat_list_screen.dart';
import 'package:myapp/chat_list/chat_model.dart'; 
import 'Pantalla-Conversacion.dart'; // ChatScreen
import 'Pantalla-Perfil.dart';      // ProfileScreen
import 'Pantalla-Inicio.dart';     // HomeScreen
import 'Pantalla-Login.dart';      // ⭐ NUEVA IMPORTACIÓN: LoginPage

final router = GoRouter(
  // ⭐ INICIO: Establece /login como la primera pantalla.
  initialLocation: '/login',
  routes: [
    
    // ⭐ RUTA DE LOGIN
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(), // Asumiendo que es tu clase LoginPage
    ),

    // Home Route (La ruta principal de la aplicación)
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
      // Rutas anidadas para la conversación individual
      routes: [
        GoRoute(
          path: ':chatId', 
          builder: (BuildContext context, GoRouterState state) {
            final chatId = state.pathParameters['chatId']!;
            final chatData = state.extra;

            return ChatScreen(
              chatId: chatId, 
              chat: chatData is Chat ? chatData : null, 
            ); 
          },
        ),
      ],
    ),
  ],

  // Manejo de errores (sin cambios)
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