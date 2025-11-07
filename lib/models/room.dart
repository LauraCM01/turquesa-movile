class Room {
  final int id;
  final String nombre;
  final String tipo;
  final int capacidad;
  final double precio;
  final String descripcion;
  final bool disponible;
  final String imagen;
  final String camasInfo;
  final bool wifi;
  final bool tv;
  final bool estacionamiento;
  final bool mascotas;
  final bool closet;
  final bool lavanderia;
  final String checkinHora;
  final String checkoutHora;

  Room({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.capacidad,
    required this.precio,
    required this.descripcion,
    required this.disponible,
    required this.imagen,
    required this.camasInfo,
    required this.wifi,
    required this.tv,
    required this.estacionamiento,
    required this.mascotas,
    required this.closet,
    required this.lavanderia,
    required this.checkinHora,
    required this.checkoutHora,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
      capacidad: json['capacidad'] ?? 0,
      precio: double.tryParse(json['precio'].toString()) ?? 0.0,
      descripcion: json['descripcion'] ?? '',
      disponible: json['disponible'] ?? false,
      imagen: json['imagen'] ?? '',
      camasInfo: json['camas_info'] ?? '',
      wifi: json['wifi'] ?? false,
      tv: json['tv'] ?? false,
      estacionamiento: json['estacionamiento'] ?? false,
      mascotas: json['mascotas'] ?? false,
      closet: json['closet'] ?? false,
      lavanderia: json['lavanderia'] ?? false,
      checkinHora: json['checkin_hora'] ?? '',
      checkoutHora: json['checkout_hora'] ?? '',
    );
  }
}


