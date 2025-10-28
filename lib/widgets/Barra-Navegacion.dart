import 'package:flutter/material.dart';
import 'package:myapp/Pantalla-Inicio.dart';
import 'package:myapp/Pantalla-Perfil.dart';
import 'package:myapp/chat_screen.dart';

class BarraNavegacion extends StatefulWidget {
  final int selectedIndex;

  const BarraNavegacion({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<BarraNavegacion> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: const Color(0XFF2CB7A6),
      unselectedItemColor: Colors.grey[400],
      backgroundColor: Colors.white,
      elevation: 10,
      iconSize: 20,
      selectedFontSize: 12.0, // Tamaño de fuente para el ítem seleccionado
      unselectedFontSize: 12.0, // Tamaño de fuente para los ítems no seleccionados
      
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
