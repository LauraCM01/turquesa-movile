import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/room.dart';
import 'widgets/room_card.dart';

// HomeScreen ya no necesita tener el tema o MaterialApp
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  List<Room> _allRooms = [];
  List<Room> _filteredRooms = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchRooms();
  }

  Future<void> _fetchRooms() async {
    const url =
        'https://hostalsanrosa-production.up.railway.app/api/habitaciones/todas';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final rooms = data.map((json) => Room.fromJson(json)).toList();

        setState(() {
          _allRooms = rooms;
          _filteredRooms = rooms;
          _isLoading = false;
        });
      } else {
        var codigo = response.statusCode;
        throw Exception('Error al cargar habitaciones $codigo');
      }
    } catch (e) {
      debugPrint('Error al cargar habitaciones : $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredRooms = _allRooms
          .where(
            (room) => room.nombre.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  void _addRoom(BuildContext context) {
    debugPrint('Botón "Agregar Habitación" presionado.');
  }

  @override
  Widget build(BuildContext context) {
    // ⭐ CAMBIO CLAVE: Eliminar MaterialApp y devolver Scaffold directamente.
    // El tema ya se aplica desde el MaterialApp.router principal.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(
                  child: Text(
                    'Error al cargar habitaciones wwsws',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildSearchBar(),
                      const SizedBox(height: 20),
                      Expanded(
                        child: _filteredRooms.isEmpty
                            ? Center(
                                child: Text(
                                  'No se encontraron resultados',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : GridView.count(
                                padding: const EdgeInsets.only(
                                  top: 0.0,
                                  left: 16.0,
                                  right: 16.0,
                                  bottom: 10.0,
                                ),
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                children: _filteredRooms
                                    .map((room) => RoomCard(room: room))
                                    .toList(),
                              ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => _addRoom(context),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'AGREGAR HABITACIÓN',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF2CB7A6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.0,
      toolbarHeight: 80.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: SizedBox(
              width: 150,
              child: Image.network(
                'https://res.cloudinary.com/dfznn7pui/image/upload/v1761514333/LOGO-HOSTAL_yvkmmi.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
      ),
      child: TextField(
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Buscador',
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 0.0,
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}