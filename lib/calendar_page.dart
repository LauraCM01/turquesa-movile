import 'package:flutter/material.dart';
import 'package:myapp/widgets/barranavegacion.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'room_details_screen.dart';
import './reservation_form.dart';

// ----------------------------------------------------
// 1. CONSTANTES Y MODELO DE DATOS
// ----------------------------------------------------
const Color kPrimaryColor = Color(0XFF2CB7A6);
const Color kReservedColor = Color(0xFFE53935);
const Color kAvailableColor = Color(0xFFE0E0E0);

// Mapeo de estados fijos a colores
Map<String, Color> statusColors = {
  'Reservado': kReservedColor,
  'Disponible': kAvailableColor,
};

// Mapa que simula la data de Firebase para disponibilidad
Map<DateTime, String> hostelAvailability = {
  // Fechas reservadas
  DateTime.utc(2025, 9, 26): 'Reservado',
  DateTime.utc(2025, 9, 27): 'Reservado',
  DateTime.utc(2025, 9, 28): 'Reservado',
};

// ----------------------------------------------------
// 2. WIDGET DE CALENDARIO (ESTRUCTURA BASE)
// ----------------------------------------------------

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // 1. DECLARACIÓN DE VARIABLES DE ESTADO (CORREGIDO Y UNIFICADO)
  DateTime _focusedDay = DateTime.utc(2025, 9, 1);
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  PageController? _pageController;

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Variables de Rango (NECESARIAS si usaste el código de rangos, aunque no las uses)
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // 2. FUNCIONES DE LÓGICA

  // Manejo de la selección de un solo día
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // Reiniciamos el rango si se selecciona un solo día
        _rangeStart = null;
        _rangeEnd = null;
      });
      //print('Día seleccionado: $selectedDay');

      final normalizedDay = DateTime.utc(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
      );
      final String status = hostelAvailability[normalizedDay] ?? 'Disponible';

      if (status == 'Reservado') {
        // Lógica de navegación:
        Navigator.push(
          context,
          MaterialPageRoute(
            // Debes crear una nueva pantalla, por ejemplo 'ReservationDetailsScreen'
            builder: (context) => RoomDetailsScreen(
              // Le pasas la fecha para que sepa qué reserva mostrar
              //date: selectedDay,
            ),
          ),
        );
      } else {
        // El status es 'Disponible'

        // Lógica de navegación:
        Navigator.push(
          context,
          MaterialPageRoute(
            // Debes crear otra pantalla, por ejemplo 'NewReservationFormScreen'
            builder: (context) => ReservationForm(
              // Le pasas la fecha para que el formulario ya sepa qué día se va a reservar
              //date: selectedDay,
            ),
          ),
        );
      }
    }
  }

  // Manejo de la selección de Rango (Incluido para evitar errores con código anterior)
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  // FUNCIÓN CLAVE: Construye la apariencia de cada día (círculos de colores)
  Widget _buildDayContainer(DateTime day, DateTime focusedDay) {
    final normalizedDay = day.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

    Color backgroundColor;
    Color textColor;

    // LÓGICA DE SELECCIÓN DE RANGO (Prioridad 1: Días intermedios en un rango)
    // Nota: Desactiva el rango en TableCalendar si no lo vas a usar.
    if (_rangeStart != null &&
        _rangeEnd != null &&
        day.isAfter(_rangeStart!) &&
        day.isBefore(_rangeEnd!)) {
      backgroundColor = kPrimaryColor;
      textColor = Colors.white;
    }
    // LÓGICA DE SELECCIÓN SIMPLE (Prioridad 2: Día Seleccionado o inicio/fin de rango)
    else if (isSameDay(_selectedDay, day) ||
        isSameDay(_rangeStart, day) ||
        isSameDay(_rangeEnd, day)) {
      backgroundColor = kPrimaryColor; // Verde Turquesa (Seleccionado)
      textColor = Colors.white;
    }
    // LÓGICA DE ESTADOS FIJOS (Prioridad 3: Reservado / Disponible)
    else {
      final String status = hostelAvailability[normalizedDay] ?? 'Disponible';
      backgroundColor = statusColors[status] ?? kAvailableColor;
      textColor = (status == 'Disponible') ? Colors.grey : Colors.white;
    }

    // Contenedor circular
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        // Borde para el día de hoy
        border: isSameDay(day, DateTime.now()) && _selectedDay == null
            ? Border.all(color: kPrimaryColor.withOpacity(0.5), width: 1.5)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  // 3. WIDGET BUILD (VISTA)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
        255,
        255,
        255,
        255,
      ), // Fondo ligero del diseño
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: const BackButton(color: kPrimaryColor),
        title: const Text(
          'Habitación doble',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Simulación de la imagen de la habitación
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://res.cloudinary.com/dfznn7pui/image/upload/v1760068145/pop_9_ilwxua.png', // REEMPLAZA CON EL NOMBRE REAL DE TU ARCHIVO
                    fit: BoxFit
                        .cover, // Para que la imagen cubra todo el espacio
                  ),
                ),
              ),
            ),

            // Título del Mes (Septiembre) y flechas
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.MMMM('es').format(_focusedDay).capitalize(),
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      // Flechas de navegación (funcionalidad no implementada)
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _pageController?.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _pageController?.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // El Widget principal del Calendario (AÑADIMOS EL PADDING AQUÍ)
            Padding(
              // 🔥 MODIFICACIÓN CLAVE: Padding horizontal para el calendario
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TableCalendar(
                onCalendarCreated: (PageController controller) {
                  _pageController = controller;
                },
                locale: 'es',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,

                headerVisible: false, // Ocultamos el header por defecto

                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),

                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,
                  outsideDaysVisible: true,
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(26, 188, 156, 1),
                  ),
                ),

                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    return _buildDayContainer(day, focusedDay);
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return _buildDayContainer(day, focusedDay);
                  },
                ),

                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // LEYENDA (Los 3 Estados)
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 10.0,
                bottom: 40.0,
              ),
              child: Wrap(
                spacing: 16.0,
                runSpacing: 8.0, // Espacio vertical entre líneas si hace wrap
                alignment: WrapAlignment.center, // Centra los ítems

                children: [
                  _buildLegendItem(kPrimaryColor, 'Seleccionado'),
                  _buildLegendItem(kReservedColor, 'Reservado'),
                  _buildLegendItem(kAvailableColor, 'Disponible'),
                  _buildLegendItem(
                    const Color.fromARGB(255, 99, 99, 97),
                    'Fuera de servicio',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: BarraNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// FUNCIONES AUXILIARES (DEBEN IR FUERA DE LA CLASE _CalendarPageState)
// Función auxiliar para construir los ítems de la leyenda
Widget _buildLegendItem(Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 5),
      Text(
        text,
        // 🔥 MODIFICACIÓN CLAVE: Cambiar color y tamaño de fuente aquí
        style: const TextStyle(
          fontSize: 12, // <-- Aumentar el tamaño a 16 (puedes ajustar)
          color:
              Colors.grey, // <-- Cambiar a color negro (o el color que desees)
          fontWeight:
              FontWeight.normal, // Opcional: Define el peso de la fuente
        ),
      ),
    ],
  );
}

// Extensión para poner la primera letra en mayúscula
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
