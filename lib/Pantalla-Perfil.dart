
import 'package:flutter/material.dart';
import 'package:myapp/widgets/Barra-Navegacion.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

   

  @override
  Widget build(BuildContext context) {
   int _selectedIndex = 2;
   void _onItemTapped(int index) {
      _selectedIndex = index;
  }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF2CB7A6)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Perfil',
          style: TextStyle(color: Color(0XFF2CB7A6), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Color(0XFF2CB7A6)),
            onPressed: () {
              // TODO: Implementar cierre de sesión
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0XFF2CB7A6),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(label: 'Nombre', value: 'Adriana zuleta'),
              const SizedBox(height: 20),
              _buildTextField(label: 'Usuario', value: 'Recepcionista-2'),
              const SizedBox(height: 20),
              _buildTextField(label: 'Correo', value: 'Adriana@hoataturquesa.com'),
              const SizedBox(height: 20),
              _buildDateField(label: 'Fecha de nacimiento', value: '28/06/1983'),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implementar cierre de sesión
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF2CB7A6),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'CERRAR SESIÓN',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      
bottomNavigationBar: BarraNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );

    
  }

  Widget _buildTextField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
