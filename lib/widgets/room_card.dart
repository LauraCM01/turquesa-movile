import 'package:flutter/material.dart';
import 'package:myapp/Pantalla-Calendario.dart' hide kPrimaryColor;
import 'package:myapp/models/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({super.key, required this.room});

  void _goToCalendar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalendarPage(room: room),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: InkWell(
        onTap: () => _goToCalendar(context),
        child: Card(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Column(
            children: [
              // Imagen (valida si no existe o da error)
              Expanded(
                flex: 3,
                child: Ink.image(
                  image: _getRoomImage(room.imagen),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      debugPrint('Ver detalles de ${room.nombre}');
                    },
                  ),
                ),
              ),
              // Nombre y botón
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          room.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Color(0XFF2CB7A6),
                          size: 28,
                        ),
                        onPressed: null,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Función auxiliar que valida la imagen y devuelve un ImageProvider
  ImageProvider _getRoomImage(String? url) {
    // Si la URL es nula o vacía, usar la imagen por defecto
    if (url == null || url.isEmpty) {
      return const AssetImage('assets/images/default_room.jpg');
    }

    // Si la URL es válida, devolver NetworkImage,
    // y el errorBuilder mostrará la imagen de respaldo si falla.
    return NetworkImage(url);
  }
}
