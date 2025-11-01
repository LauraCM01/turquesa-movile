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
// 1. CONSTANTES Y MODELO DE DATOS
// ----------------------------------------------------
const Color kPrimaryColor = Color(0XFF2CB7A6);
const Color kReservedColor = Color(0xFFE53935);
const Color kAvailableColor = Color(0xFFE0E0E0);
// Se elimina la constante kUnknownSelectedColor

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
  final Room room;
  const CalendarPage({super.key, required this.room});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // 1. DECLARACIÓN DE VARIABLES DE ESTADO
  DateTime _focusedDay = DateTime.utc(2025, 9, 1);
  DateTime? _selectedDay = DateTime.utc(2025, 9, 1);
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  PageController? _pageController;

  Calendarioservice calendarioservice = Calendarioservice();
  

  
  // Variables de Rango
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // 2. FUNCIONES DE LÓGICA

  // Manejo de la selección de un solo día
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // Usamos isSameDay de table_calendar
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        // ✅ CORRECCIÓN CLAVE: Al seleccionar un día, forzamos que el _focusedDay
        // sea el día seleccionado (o su mes), lo cual es el comportamiento esperado
        // de TableCalendar para actualizar la vista correctamente.
        _focusedDay = selectedDay;
        _rangeStart = null;
        _rangeEnd = null;
      });

      final normalizedDay = DateTime.utc(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
      );
      final String status = hostelAvailability[normalizedDay] ?? 'Disponible';

      if (status == 'Reservado') {
        // Lógica de navegación a detalles de la reserva
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RoomDetailsScreen(
              //date: selectedDay,
            ),
          ),
        );
      } else {
        // Lógica de navegación a formulario de nueva reserva
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReservationForm(
              //date: selectedDay,
            ),
          ),
        );
      }
    }
  }

  // Manejo de la selección de Rango (Implementado pero no utilizado en el UI)
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  // FUNCIÓN CLAVE: Construye la apariencia de cada día (círculos de colores)
  Widget _buildDayContainer(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    // --- Lógica de Días Fuera de Mes (Fuera de rango visible) ---
    // ✅ Usamos la función isSameMonthLocal
    final bool isOutside = !isSameMonthLocal(day, focusedDay);

    // Normalizar el día para buscar en el mapa de disponibilidad
    final normalizedDay = day.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

    Color backgroundColor;
    Color textColor;

    // --------------------------------------------------
    // 1. Prioridad Máxima: DÍA SELECCIONADO (Turquesa - kPrimaryColor)
    //    Esta lógica ahora será redundante para el selectedBuilder, pero
    //    es necesaria para los builders default y outside.
    // --------------------------------------------------

    // Usamos isSameDay de table_calendar
    if (isSameDay(_selectedDay, day) ||
        isSameDay(_rangeStart, day) ||
        isSameDay(_rangeEnd, day)) {
      // Si está seleccionado (o es inicio/fin de rango), el color es SIEMPRE Turquesa
      backgroundColor = kPrimaryColor;
      textColor = Colors.white;
    }
    // --------------------------------------------------
    // 2. Prioridad Media: DÍAS EN RANGO (Se mantiene el Turquesa, pero esto es redundante)
    // --------------------------------------------------
    else if (_rangeStart != null &&
        _rangeEnd != null &&
        day.isAfter(_rangeStart!) &&
        day.isBefore(_rangeEnd!)) {
      backgroundColor = kPrimaryColor;
      textColor = Colors.white;
    }
    // --------------------------------------------------
    // 3. Prioridad Baja: ESTADOS FIJOS (Reservado/Disponible)
    // --------------------------------------------------
    else {
      final String status = hostelAvailability[normalizedDay] ?? 'Disponible';
      backgroundColor = statusColors[status] ?? kAvailableColor;
      textColor = (status == 'Disponible') ? Colors.grey : Colors.white;
    }

    // --------------------------------------------------
    // 4. LÓGICA DE OPACIDAD (Se aplica al color ya determinado)
    // --------------------------------------------------
    // SOLO aplicamos opacidad si es fuera de mes Y no es el día seleccionado.
    if (isOutside && !isSameDay(_selectedDay, day)) {
      // Reducimos la opacidad si es un día fuera del mes Y NO ES EL DÍA SELECCIONADO
      backgroundColor = backgroundColor.withOpacity(0.5);
      textColor = Colors.grey.withOpacity(0.5);
    }

    // 🌟 TAMAÑO DE FUENTE FIJO
    const double fixedFontSize = 14.0;

    // Contenedor circular
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        // Borde para el día de hoy (solo si no está seleccionado y no es un día fuera del mes)
        // Usamos isSameDay de table_calendar
        border:
            isSameDay(day, DateTime.now()) &&
                !isSameDay(_selectedDay, day) &&
                !isOutside
            ? Border.all(color: kPrimaryColor.withOpacity(0.7), width: 1.5)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          // 🔥 USO DE TAMAÑO FIJO
          fontSize: fixedFontSize,
        ),
      ),
    );
  }

  // ✅ NUEVA FUNCIÓN: Constructor dedicado para el día seleccionado (garantiza el color Turquesa)
  Widget _buildSelectedDayContainer(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    // El día seleccionado siempre debe ser Turquesa y el texto blanco
    Color backgroundColor = kPrimaryColor;
    Color textColor = Colors.white;

    // La opacidad solo se aplica al texto si está fuera del mes, pero mantenemos el fondo fuerte
    final bool isOutside = !isSameMonthLocal(day, focusedDay);
    Color finalTextColor = isOutside
        ? Colors.white.withOpacity(0.7)
        : Colors.white;

    const double fixedFontSize = 14.0;

    // Contenedor circular con el color Turquesa asegurado
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroundColor, // KPrimaryColor (Turquesa)
        shape: BoxShape.circle,
        border: isSameDay(day, DateTime.now())
            ? Border.all(color: Colors.white, width: 2.0)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: finalTextColor,
          fontWeight: FontWeight.w700,
          fontSize: fixedFontSize,
        ),
      ),
    );
  }

  // 3. WIDGET BUILD (VISTA)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        elevation: 0,
        // Reemplazamos BackButton por un IconButton con la misma funcionalidad
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.room.name,
          style: GoogleFonts.poppins(
            color: const Color(0XFF2CB7A6),
            fontWeight: FontWeight.bold,
          ),
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
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.network(
                    widget.room.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text("Error al cargar imagen"),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Título del Mes (Septiembre) y flechas
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.MMMM('es').format(_focusedDay).capitalize(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      // Flechas de navegación
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                    fontSize: 12,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                // Se elimina calendarStyle.selectedDecoration para que
                // TableCalendar no aplique su propia decoración animada.
                // La decoración del día seleccionado se maneja completamente en _buildDayContainer.
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,
                  outsideDaysVisible: true,
                ),

                calendarBuilders: CalendarBuilders(
                  // ✅ NUEVO BUILDER: Garantiza el estilo del día seleccionado (máxima prioridad)
                  selectedBuilder: (context, day, focusedDay) {
                    return _buildSelectedDayContainer(context, day, focusedDay);
                  },
                  // Usa el mismo builder para todos los días visibles (incluyendo default)
                  defaultBuilder: (context, day, focusedDay) {
                    return _buildDayContainer(context, day, focusedDay);
                  },
                  // Usa el mismo builder para los días de otros meses
                  outsideBuilder: (context, day, focusedDay) {
                    return _buildDayContainer(context, day, focusedDay);
                  },
                ),

                onDaySelected: _onDaySelected,
                // Usamos isSameDay de table_calendar
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
                top: 5.0,
                bottom: 20.0,
              ),
              child: Wrap(
                spacing: 16.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,

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

      bottomNavigationBar: const BarraNavegacion(selectedIndex: 1),
    );
  }
}

// FUNCIONES AUXILIARES (DEBEN IR FUERA DE LA CLASE _CalendarPageState)

// SOLUCIÓN AL ERROR: Implementación local de isSameMonth
bool isSameMonthLocal(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }
  return a.year == b.year && a.month == b.month;
}

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
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
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
