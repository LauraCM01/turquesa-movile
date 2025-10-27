import 'package:flutter/material.dart';
import 'package:myapp/models/room.dart';
import './calendar_page.dart';
import 'widgets/barranavegacion.dart';
import './chat_screen.dart';
import './inicio.dart';
import './perfil_screen.dart';
import 'widgets/room_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Lista de habitaciones simuladas
  final List<Room> dummyRooms = [
    Room(
      name: 'Habitación Familiar',
      imageUrl:
          'https://res.cloudinary.com/dfznn7pui/image/upload/v1760064533/habitacion_9_mhcbqn.png',
      id: 'R001',
    ),
    Room(
      name: 'Habitación Doble',
      imageUrl:
          'https://res.cloudinary.com/dfznn7pui/image/upload/v1760066812/habitacion_11_b4afjs.png',
      id: 'R002',
    ),
    Room(
      name: 'Habitación Triple',
      imageUrl:
          'https://res.cloudinary.com/dfznn7pui/image/upload/v1760064533/habitacion_9_mhcbqn.png',
      id: 'R003',
    ),
    Room(
      name: 'Habitación Suite',
      imageUrl:
          'https://res.cloudinary.com/dfznn7pui/image/upload/v1760064532/habitacion_3_tyjjyj.png',
      id: 'R004',
    ),
    Room(
      name: 'Habitación Familiar',
      imageUrl:
          'https://res.cloudinary.com/dfznn7pui/image/upload/v1760064532/habitacion_3_tyjjyj.png',
      id: 'R005',
    ),
    Room(
      name: 'Habitación Doble',
      imageUrl:
          'https://res.cloudinary.com/dfznn7pui/image/upload/v1760064532/habitacion_3_tyjjyj.png',
      id: 'R006',
    ),
  ];

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
    return MaterialApp(
      title: 'Turquesa Hostal',
      theme: ThemeData(
        primaryColor: Color(0XFF2CB7A6),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),

      home: Scaffold(
        backgroundColor: Colors.white,
        // 1. Barra superior (AppBar)
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          // MODIFICACIÓN 1: Aumentar la altura de la barra (el valor por defecto es ~56.0)
          toolbarHeight: 80.0, // Puedes ajustar este valor
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ), // Agrega margen vertical y horizontal
                child: SizedBox(
                  width: 150,
                  child: Image.network(
                    'https://res.cloudinary.com/dfznn7pui/image/upload/v1761514333/LOGO-HOSTAL_yvkmmi.png',
                    fit: BoxFit.contain,
                    loadingBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                    errorBuilder:
                        (
                          BuildContext context,
                          Object exception,
                          StackTrace? stackTrace,
                        ) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                  ),
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
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 10.0,
                  ),

                  // Esto define el layout 2x2
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0, // Espacio horizontal entre tarjetas
                  mainAxisSpacing: 16.0, // Espacio vertical entre tarjetas
                  children: dummyRooms.map((room) {
                    return RoomCard(room: room);
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
                    'AGREGAR HABITACIÓN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF2CB7A6),
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
        bottomNavigationBar: BarraNavegacion(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  // Widget para la Barra de Búsqueda
  Widget _buildSearchBar() {
    return Container(
      // ELIMINAMOS el padding del Container
      // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
        color: Colors.grey.shade400, // Un gris claro para un borde sutil
        width: 1.0, // Un ancho de 1.0 es generalmente bueno para la sutileza
        ),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Buscador',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,

          contentPadding: EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
          ),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
