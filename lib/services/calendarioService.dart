import 'package:cloud_firestore/cloud_firestore.dart';

class Calendarioservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> guardarRangoFechas({
    required DateTime fechaInicio,
    required DateTime fechaFin,
    required String habitacionId,
    required String estado,
  }) async {
    try {
      await _firestore.collection('calendario').add({
        'fecha_inicio': Timestamp.fromDate(fechaInicio),
        'fecha_fin': Timestamp.fromDate(fechaFin),
        'habitacionId': habitacionId,
        'estado': estado,
        'fecha_creacion': FieldValue.serverTimestamp(),
      });
      print('Rango de fechas guardado exitosamente.');
    } catch (e) {
      print('Error al guardar el rango de fechas: $e');
      // Re-throw the exception to be handled by the UI
      throw e;
    }
  }

  // Method to get events for a given room, ordered by start date
  Stream<QuerySnapshot> getEventosPorHabitacion(String habitacionId) {
    return _firestore
        .collection('calendario')
        .where('habitacionId', isEqualTo: habitacionId)
        .orderBy('fecha_inicio')
        .snapshots();
  }


  // Method to get a specific event by its document ID
  Future<DocumentSnapshot> getEventoPorId(String eventoId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('calendario').doc(eventoId).get();
      return doc;
    } catch (e) {
      print('Error al obtener el evento por ID: $e');
      rethrow;
    }
  }
}
