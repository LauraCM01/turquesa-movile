import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/Barra-Navegacion.dart';
import 'Pantalla-Login.dart';
import 'Pantalla-Inicio.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // ✅ SOLUCIÓN: Definir el estilo de texto para los valores
  final TextStyle _valueTextStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );

  // ✅ SOLUCIÓN: Definir la función que crea el borde
  OutlineInputBorder _customBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF2CB7A6)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Text(
          'Perfil',
          style: GoogleFonts.poppins(
            color: const Color(0XFF2CB7A6),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Color(0XFF2CB7A6)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Color(0x1A2CB7A6),
                child: Icon(Icons.person, size: 70, color: Color(0XFF2CB7A6)),
              ),
              const SizedBox(height: 30),
              _buildTextField(label: 'Nombre', value: 'Adriana Zuleta'),
              const SizedBox(height: 20),
              _buildTextField(label: 'Usuario', value: 'Recepcionista-2'),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Correo',
                value: 'adriana@hostalturquesa.com',
              ),
              const SizedBox(height: 20),
              _buildDateField(
                label: 'Fecha de nacimiento',
                value: '28/06/1983',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF2CB7A6),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'CERRAR SESIÓN',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BarraNavegacion(selectedIndex: 2),
    );
  }

  Widget _buildTextField({required String label, required String value}) {
    // 💡 CAMBIO: El Padding ahora envuelve todo el Column
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ), // Ajuste horizontal
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Esta es la etiqueta que queremos mover
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: value,
            readOnly: true,
            style: _valueTextStyle,
            decoration: InputDecoration(
              // El padding interno (contentPadding) se mantiene para el texto
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10.0,
              ),
              enabledBorder: _customBorder(color: Color(0XFF2CB7A6)),
              focusedBorder: _customBorder(color: Color(0XFF2CB7A6)),
              border: _customBorder(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({required String label, required String value}) {
    // 💡 CAMBIO: El Padding ahora envuelve todo el Column
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      ), // Ajuste horizontal
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: value,
            readOnly: true,
            style: _valueTextStyle,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10.0,
              ),
              enabledBorder: _customBorder(color: Color(0XFF2CB7A6)),
              focusedBorder: _customBorder(color: Color(0XFF2CB7A6)),
              border: _customBorder(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
