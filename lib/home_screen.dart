import 'package:flutter/material.dart';
import './calendar_page.dart';

const Color kPrimaryColor = Color(0xFF4DB6AC); // Un turquesa bonito

// --- 1. Modelo de Datos (Simulación) ---
// Representa una Habitación con sus datos esenciales.
class Room {
  final String name;
  final String imageUrl;
  final String id;

  Room({required this.name, required this.imageUrl, required this.id});
}

// --- 2. Pantalla Principal de la Aplicación ---
class HomeScreen extends StatelessWidget {
  // Lista de habitaciones simuladas (4 para cumplir la corrección)
  final List<Room> dummyRooms = [
    Room(
      name: 'Doble Premium',
      imageUrl: 'https://placehold.co/600x400/80CBC4/FFFFFF?text=Doble',
      id: 'R001',
    ),
    Room(
      name: 'Familiar Vista Mar',
      imageUrl: 'https://placehold.co/600x400/4DB6AC/FFFFFF?text=Familiar',
      id: 'R002',
    ),
    Room(
      name: 'Individual Estándar',
      imageUrl: 'https://placehold.co/600x400/26A69A/FFFFFF?text=Individual',
      id: 'R003',
    ),
    Room(
      name: 'Suite Deluxe',
      imageUrl: 'https://placehold.co/600x400/00897B/FFFFFF?text=Suite',
      id: 'R004',
    ),
  ];

  HomeScreen({super.key});

  // Función de ejemplo para agregar una habitación (Aquí integrarás Firebase después)
  void _addRoom() {
    // Aquí es donde iría la lógica para abrir el formulario de
    // agregar habitación y la conexión a Firebase Firestore.
    debugPrint('Botón "Agregar Habitación" presionado.');
    // Muestra una notificación simple para el usuario
    // (En una app real usarías Navigator para ir a otra pantalla)
    // En este ejemplo, solo usaremos un snackbar.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Barra superior (AppBar)
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.house_siding_rounded,
              color: kPrimaryColor,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'TURQUESA HOSTAL',
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 2. Barra de Búsqueda
            _buildSearchBar(),
            const SizedBox(height: 20),

            // 3. Grid de 2x2 para las Habitaciones
            Expanded(
              child: GridView.count(
                // Esto define el layout 2x2
                crossAxisCount: 2,
                crossAxisSpacing: 16.0, // Espacio horizontal entre tarjetas
                mainAxisSpacing: 16.0, // Espacio vertical entre tarjetas
                children: dummyRooms.map((room) {
                  return _RoomCard(room: room);
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Botón de Agregar Habitación
            ElevatedButton.icon(
              onPressed: _addRoom,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  '+ AGREGAR HABITACIÓN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
      // 5. Barra de Navegación Inferior (simulada del diseño original)
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.white,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  // Widget para la Barra de Búsqueda
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Buscador',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          isDense: true, // Reduce el espacio vertical
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

// --- 3. Tarjeta de Habitación (La clave para la forma cuadrada) ---
class _RoomCard extends StatelessWidget {
  final Room room;

  const _RoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // ¡Esto asegura que la tarjeta SIEMPRE sea cuadrada!
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        child: Column(
          children: [
            // Imagen ocupando la mayor parte del espacio
            Expanded(
              flex: 3,
              child: Ink.image(
                image: NetworkImage(room.imageUrl),
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    // Acción al tocar la imagen
                    debugPrint('Ver detalles de ${room.name}');
                  },
                ),
              ),
            ),
            // Nombre y Botón '+'
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Nombre
                    Flexible(
                      child: Text(
                        room.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Botón '+'
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                      onPressed: () {
                        // Acción al presionar el '+'
                        //debugPrint('Agregado: ${room.name}');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CalendarPage(),
                          ),
                        );
                      },
                      padding: EdgeInsets
                          .zero, // Elimina el padding extra para que el ícono sea más grande
                      constraints:
                          const BoxConstraints(), // Elimina restricciones de tamaño
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 4. Configuración Inicial de la App (en lib/main.dart) ---
// Normalmente, este código iría en main.dart para arrancar la app.
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turquesa Hostal',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        useMaterial3: true,
        fontFamily: 'Inter', // Puedes usar otra fuente si lo deseas
      ),
      home: HomeScreen(), // ¡Aquí llamamos a la pantalla que creamos!
    );
  }
}
*/