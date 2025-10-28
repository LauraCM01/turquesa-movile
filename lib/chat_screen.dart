import 'package:flutter/material.dart';
import 'package:myapp/widgets/Barra-Navegacion.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
         backgroundColor: Color(0XFF2CB7A6),
      ),
      body: const Center(
        child: Text('Chat Screen'),
      ),
      bottomNavigationBar: const BarraNavegacion(selectedIndex: 0),
    );
  }
}
