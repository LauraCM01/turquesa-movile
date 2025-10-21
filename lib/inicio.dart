import 'package:flutter/material.dart';
import './loging.dart';
import './calendar_page.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CalendarPage());
  }
}
