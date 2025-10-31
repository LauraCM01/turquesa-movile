
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2CB7A6)),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Chat App',
      theme: theme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme),
      ),
      home: const ChatScreen(),
    );
  }
}
