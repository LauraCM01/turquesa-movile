import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/room_status.dart';
import 'package:myapp/providers/room_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/widgets/Barra-Navegacion.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});


  // 2. WIDGET BUILD (VISTA)
  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0, // Elimina la sombra cuando NO hay scroll
        scrolledUnderElevation: 0.0, // Elimina la sombra cuando SÍ hay scroll
        surfaceTintColor: Colors.transparent, // Asegura que el color de fondo no cambie por el tema
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF2CB7A6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Habitación doble',
          style: GoogleFonts.poppins(
            color: const Color(0XFF2CB7A6),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0XFF2CB7A6)),
            onPressed: () {},
          ),
        ],
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
                    color: const Color(0XFF2CB7A6),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'NÚMERO DE RESERVA: 31145',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Huésped:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Laura Martínez',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey, // Cambia Colors.grey por el color deseado
                ),
              ),
              const SizedBox(height: 16.0),
              _buildInfoRow('Número de personas:', '2 adultos'),
              _buildInfoRow('Llegada:', '19 de septiembre de 2025 - 3:00 p.m.'),
              _buildInfoRow('Salida:', '21 de septiembre de 2025 - 11:00 a.m.'),
              _buildInfoRow('Número de contacto:', '3114586237'),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFF2CB7A6)),
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
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2CB7A6),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: const Color(0xFF2CB7A6),
                      ),
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
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF2CB7A6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔥 3. AGREGAR BARRA DE NAVEGACIÓN
      bottomNavigationBar: const BarraNavegacion(
        selectedIndex: 1,
      ),
    );
  }

  // Los métodos auxiliares deben moverse FUERA del método build,
  // pero DENTRO de la clase _RoomDetailsScreenState
  Widget _buildInfoRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8.0, color: Color(0XFF2CB7A6)),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Mueve esta función DENTRO de la clase _RoomDetailsScreenState
  void _showStatusMenu(BuildContext context) {
    // 🔥 CAMBIAR showModalBottomSheet por showDialog
    showDialog(
      context: context,
      builder: (context) {
        // Usaremos AlertDialog como contenedor central
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Cambiar Estado',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0XFF2CB7A6),
            ),
          ),
          // 🔥 Reemplazamos Wrap con un Column y los ListTiles
          content: Column(
            mainAxisSize: MainAxisSize.min, // Hace que el diálogo sea compacto
            children: [
              ListTile(
                leading: const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF2CB7A6),
                ),
                title: Text(
                  'DISPONIBLE',
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                ),
                onTap: () {
                  // Usamos context.read() ya que no estamos en el método build
                  Provider.of<RoomProvider>(
                    context,
                    listen: false,
                  ).setStatus(RoomStatus.disponible);
                  Navigator.pop(context); // Cierra el diálogo
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.cleaning_services,
                  color: Color(0xFF2CB7A6),
                ),
                title: Text(
                  'EN LIMPIEZA',
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                ),
                onTap: () {
                  Provider.of<RoomProvider>(
                    context,
                    listen: false,
                  ).setStatus(RoomStatus.enLimpieza);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.build, color: Color(0xFF2CB7A6)),
                title: Text(
                  'MANTENIMIENTO',
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                ),
                onTap: () {
                  Provider.of<RoomProvider>(
                    context,
                    listen: false,
                  ).setStatus(RoomStatus.mantenimiento);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.bed, color: Color(0xFF2CB7A6)),
                title: Text(
                  'OCUPADA',
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                ),
                onTap: () {
                  Provider.of<RoomProvider>(
                    context,
                    listen: false,
                  ).setStatus(RoomStatus.ocupada);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          // Opcional: Agregar un botón de cerrar en la esquina inferior del diálogo
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CANCELAR',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
