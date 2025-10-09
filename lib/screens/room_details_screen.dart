import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/room_status.dart';
import 'package:myapp/providers/room_provider.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Habitación doble'),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2CB7A6),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'NÚMERO DE RESERVA: 31145',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Huésped:',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Laura Martínez', style: GoogleFonts.roboto(fontSize: 16)),
              const SizedBox(height: 16.0),
              _buildInfoRow('Número de personas:', '2 adultos'),
              _buildInfoRow('Llegada:', '19 de septiembre de 2025 - 3:00 p.m.'),
              _buildInfoRow('Salida:', '21 de septiembre de 2025 - 11:00 a.m.'),
              _buildInfoRow('Número de contacto:', '3114586237'),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          roomProvider.statusIcon,
                          color: const Color(0xFF2CB7A6),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          roomProvider.statusText,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2CB7A6),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: const Color(0xFF2CB7A6)),
                      onPressed: () => _showStatusMenu(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'ELIMINAR RESERVA',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF2CB7A6) ,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2CB7A6),
        items: const [
          BottomNavigationBarItem(icon: Icon(
            Icons.chat_bubble_outline, 
            color: Color.fromARGB(255, 255, 255, 255)), 
          label:'',
          ),
          BottomNavigationBarItem(icon: Icon(
            Icons.home,
            color: Color.fromARGB(255, 255, 255, 255)),
          label: ''),
          BottomNavigationBarItem(icon: Icon(
            Icons.person_outline,
            color: Color.fromARGB(255, 255, 255, 255)),
          label: ''),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildInfoRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8.0),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
              Text(subtitle, style: GoogleFonts.roboto()),
            ],
          ),
        ],
      ),
    );
  }

  void _showStatusMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('DISPONIBLE',
                  style: TextStyle(color: Color(0xFF2CB7A6))),
              onTap: () {
                Provider.of<RoomProvider>(
                  context,
                  listen: false,
                ).setStatus(RoomStatus.disponible);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cleaning_services),
              title: const Text('EN LIMPIEZA',
                  style: TextStyle(color: Color(0xFF2CB7A6))),
              onTap: () {
                Provider.of<RoomProvider>(
                  context,
                  listen: false,
                ).setStatus(RoomStatus.enLimpieza);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('MANTENIMIENTO',
                  style: TextStyle(color: Color(0xFF2CB7A6))),
              onTap: () {
                Provider.of<RoomProvider>(
                  context,
                  listen: false,
                ).setStatus(RoomStatus.mantenimiento);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bed),
              title: const Text('OCUPADA',
                  style: TextStyle(color: Color(0xFF2CB7A6))),
              onTap: () {
                Provider.of<RoomProvider>(
                  context,
                  listen: false,
                ).setStatus(RoomStatus.ocupada);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
