import 'package:flutter/material.dart';
import 'package:myapp/home_screen.dart';
import './loging.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
