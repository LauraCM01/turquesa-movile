import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/loging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          bodyLarge: const TextStyle(fontSize: 20.0),
          bodyMedium: const TextStyle(fontSize: 18.0),
          displayLarge: const TextStyle(fontSize: 50.0),
          displayMedium: const TextStyle(fontSize: 40.0),
          displaySmall: const TextStyle(fontSize: 30.0),
          headlineMedium: const TextStyle(fontSize: 25.0),
          headlineSmall: const TextStyle(fontSize: 22.0),
          titleLarge: const TextStyle(fontSize: 28.0),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
