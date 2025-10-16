
import 'package:flutter/material.dart';
import 'package:myapp/app_theme.dart';
import 'package:myapp/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation App',
      theme: AppTheme.theme,
      home: const MainScreen(),
    );
  }
}
