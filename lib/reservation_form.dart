import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Opcionalmente, podrías definir el locale aquí si quisieras cambiarlo dinámicamente
  // Locale _currentLocale = const Locale('es');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Reserva',
      debugShowCheckedModeBanner: false,
      // Añadir soporte de localización para español
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglés (por defecto)
        Locale('es', ''), // Español
      ],
      // Mantener la localización de la aplicación en español
      locale: const Locale('es'), 
      home: const ReservationForm(),
    );
  }
}
// ==========================================================
// FIN DE LA MODIFICACIÓN
// ==========================================================

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key});

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _personsController = TextEditingController();
  final TextEditingController _arrivalDateController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reservationNumberController =
      TextEditingController();

  final primaryColor = const Color(0XFF2CB7A6); // Definimos el color aquí

  @override
  void dispose() {
    _nameController.dispose();
    _personsController.dispose();
    _arrivalDateController.dispose();
    _departureDateController.dispose();
    _phoneController.dispose();
    _reservationNumberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: const Locale('es'),
          delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: Theme(
            data: ThemeData.light().copyWith(
              // Color del texto y encabezados
              colorScheme: ColorScheme.light(
                primary: primaryColor, // Color de los días seleccionados y encabezado (turquesa)
                onPrimary: Colors.white, // Color del texto en el día seleccionado (blanco)
                onSurface: Colors.black, // Color del texto de los días (negro)
              ),
              // Color de los botones (CANCELAR / OK)
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor, // Color del texto de los botones (turquesa)
                ),
              ),
              // Aplicamos la forma del diálogo usando datePickerTheme
              datePickerTheme: DatePickerThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
              ),
            ),
            child: child!,
          ),
        );
      },
    ); // <-- Cierre de showDatePicker

    // Lógica para actualizar la fecha, ahora correctamente fuera del builder
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: primaryColor, width: 1.5),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0, // Elimina la sombra cuando NO hay scroll
        scrolledUnderElevation: 0.0, // Elimina la sombra cuando SÍ hay scroll
        surfaceTintColor: Colors.transparent, // Asegura que el color de fondo no cambie por el tema
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () {
            // Navigator.pop(context); // Comentado para evitar errores de navegación en Canvas simple
          },
        ),
        title: Text(
          'Formulario',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildTextField(
                context: context,
                controller: _nameController,
                label: 'Nombre del huésped',
                inputDecoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                context: context,
                controller: _personsController,
                label: 'Número de personas',
                keyboardType: TextInputType.number,
                inputDecoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(height: 32),
              _buildDateField(
                context: context,
                controller: _arrivalDateController,
                label: 'Llegada',
                inputDecoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  suffixIcon:
                      Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 30),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(height: 32),
              _buildDateField(
                context: context,
                controller: _departureDateController,
                label: 'Salida',
                inputDecoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  suffixIcon:
                      Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 30),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                context: context,
                controller: _phoneController,
                label: 'Celular',
                keyboardType: TextInputType.phone,
                inputDecoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                context: context,
                controller: _reservationNumberController,
                label: 'Número de reserva',
                keyboardType: TextInputType.number,
                inputDecoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data
                    }
                  },
                  child: const Text(
                    'CREAR RESERVA',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context, 
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    required InputDecoration inputDecoration,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF666666),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // Manteniendo el ancho limitado al 90% para demostrar el control de ancho
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, 
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            decoration: inputDecoration,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un valor';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required InputDecoration inputDecoration,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF666666),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // Manteniendo el ancho limitado al 90% para demostrar el control de ancho
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, 
          child: TextFormField(
            controller: controller,
            readOnly: true,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            decoration: inputDecoration,
            onTap: () => _selectDate(context, controller),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, seleccione una fecha';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
