import 'package:flutter/material.dart';
import 'package:myapp/models/room.dart';
import 'package:myapp/services/calendarioService.dart';
import 'package:myapp/widgets/Barra-Navegacion.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'Pantalla-Estados.dart';
import 'Formulario-Reservas.dart';
import 'package:google_fonts/google_fonts.dart';

// ----------------------------------------------------
// 1. CONSTANTES
// ----------------------------------------------------
const Color kPrimaryColor = Color(0XFF2CB7A6);
const Color kReservedColor = Color(0xFFE53935);
const Color kAvailableColor = Color(0xFFE0E0E0);

Map<String, Color> statusColors = {
  'Reservado': kReservedColor,
  'Disponible': kAvailableColor,
};

// ----------------------------------------------------
// 2. WIDGET PRINCIPAL DEL CALENDARIO
// ----------------------------------------------------
class CalendarPage extends StatefulWidget {
  final Room room;
  const CalendarPage({super.key, required this.room});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarioService calendarioService = CalendarioService();

  Map<DateTime, String> hostelAvailability = {}; // Se llena desde la API

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  PageController? _pageController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDisponibilidad();
  }

  Future<void> cargarDisponibilidad() async {
    final data = await calendarioService.obtenerDisponibilidad(widget.room.id);
    setState(() {
      hostelAvailability = data;
      _isLoading = false;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = selectedDay;
      });

      final normalizedDay =
          DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day);
      final String status = hostelAvailability[normalizedDay] ?? 'Disponible';

      if (status == 'Reservado') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RoomDetailsScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReservationForm(),
          ),
        );
      }
    }
  }

  Widget _buildDayContainer(BuildContext context, DateTime day, DateTime focusedDay) {
    final bool isOutside = !isSameMonthLocal(day, focusedDay);
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);

    Color backgroundColor;
    Color textColor;

    if (isSameDay(_selectedDay, day)) {
      backgroundColor = kPrimaryColor;
      textColor = Colors.white;
    } else {
      final String status = hostelAvailability[normalizedDay] ?? 'Disponible';
      backgroundColor = statusColors[status] ?? kAvailableColor;
      textColor = (status == 'Disponible') ? Colors.grey : Colors.white;
    }

    if (isOutside && !isSameDay(_selectedDay, day)) {
      backgroundColor = backgroundColor.withOpacity(0.5);
      textColor = Colors.grey.withOpacity(0.5);
    }

    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: isSameDay(day, DateTime.now()) && !isSameDay(_selectedDay, day)
            ? Border.all(color: kPrimaryColor.withOpacity(0.7), width: 1.5)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.room.nombre,
          style: GoogleFonts.poppins(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Imagen de habitación
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Image.network(
                          widget.room.imagen,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text("Error al cargar imagen"));
                          },
                        ),
                      ),
                    ),
                  ),

                  // Encabezado del mes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.MMMM('es').format(_focusedDay).capitalize() +
                              ' ' +
                              DateFormat.y('es').format(_focusedDay),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
                              onPressed: () {
                                _pageController?.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TableCalendar(
                      onCalendarCreated: (controller) => _pageController = controller,
                      locale: 'es',
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      headerVisible: false,
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        weekendStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      calendarStyle: const CalendarStyle(isTodayHighlighted: false),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) =>
                            _buildDayContainer(context, day, focusedDay),
                        outsideBuilder: (context, day, focusedDay) =>
                            _buildDayContainer(context, day, focusedDay),
                        selectedBuilder: (context, day, focusedDay) =>
                            _buildDayContainer(context, day, focusedDay),
                      ),
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onPageChanged: (focusedDay) => setState(() => _focusedDay = focusedDay),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildLegendItem(kPrimaryColor, 'Seleccionado'),
                        _buildLegendItem(kReservedColor, 'Reservado'),
                        _buildLegendItem(kAvailableColor, 'Disponible'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const BarraNavegacion(selectedIndex: 1),
    );
  }
}

// ----------------------------------------------------
// FUNCIONES AUXILIARES
// ----------------------------------------------------
bool isSameMonthLocal(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month;
}

Widget _buildLegendItem(Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 15, height: 15, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 5),
      Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  );
}

extension StringExtension on String {
  String capitalize() => isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
}
