
import 'package:flutter/material.dart';
import 'package:myapp/registro.dart';
import 'package:myapp/perfil.dart'; // Importa la nueva pantalla
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/room_provider.dart';
import 'package:myapp/screens/room_details_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoomProvider(),
      child: MaterialApp(
        title: 'Hotel App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        home: const RoomDetailsScreen(),
      ),
    );
  }
}
