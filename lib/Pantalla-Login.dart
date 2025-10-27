// Importa la biblioteca principal de Material Design de Flutter.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pantalla-Inicio.dart';
import 'Pantalla-Registro.dart';

// Define la clase LoginPage, que es un widget con estado (StatefulWidget).
class LoginPage extends StatefulWidget {
  // El constructor constante mejora el rendimiento.
  const LoginPage({super.key});

  @override
  // El método createState es obligatorio en un StatefulWidget y devuelve una instancia de su clase de estado asociada.
  State<LoginPage> createState() => _LoginPageState();
}

// La clase _LoginPageState contiene el estado y la lógica de la interfaz de usuario para LoginPage.
// El guion bajo (_) al principio del nombre la hace privada para este archivo.
class _LoginPageState extends State<LoginPage> {
  // Aquí puedes declarar variables que mantendrán el estado del widget,
  // como los controladores para los campos de texto o el estado de un checkbox.
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;

  @override
  // El método build es el corazón de cualquier widget.
  // Dibuja la interfaz de usuario en la pantalla y se llama cada vez que Flutter necesita renderizar el widget.
  // En un StatefulWidget, se llama cuando se invoca a setState().
  Widget build(BuildContext context) {
    // Scaffold es como un andamio para construir una pantalla de Material Design.
    return Scaffold(
      // Define el color de fondo de toda la pantalla.
      backgroundColor: Colors.white,
      // SafeArea es un widget crucial que ajusta su contenido para evitar que se superponga
      // con elementos del sistema operativo.
      body: SafeArea(
        // SingleChildScrollView permite que su contenido sea desplazable.
        child: SingleChildScrollView(
          // Padding añade un espacio vacío alrededor de su widget hijo.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            // Column organiza a sus hijos en una lista vertical.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 60.0),

                // Logo de la marca.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // Define el ancho y alto deseado para tu logo.
                      width: 200, // Ejemplo de ancho
                      child: Image.network(
                        // ¡TODO: Reemplaza esta URL de ejemplo con la URL real de tu logo!
                        'https://res.cloudinary.com/dfznn7pui/image/upload/v1761514333/LOGO-HOSTAL_yvkmmi.png',
                        fit: BoxFit
                            .contain, // Ajusta cómo se muestra la imagen dentro del SizedBox
                        loadingBuilder:
                            (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                        errorBuilder:
                            (
                              BuildContext context,
                              Object exception,
                              StackTrace? stackTrace,
                            ) {
                              // Widget a mostrar si la imagen no se puede cargar (por ejemplo, un ícono o texto de error)
                              return const Icon(Icons.error, color: Colors.red);
                            },
                      ),
                    ),
                  ],
                ),

                // Icono usuario.
                Padding(
                  // Aplica 20.0 de margen en la parte superior (top)
                  // y 20.0 a la izquierda y derecha (left, right).
                  // La parte inferior (bottom) se queda en 0.0.
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    bottom: 0.0, // O simplemente omites el 'bottom' ya que por defecto es 0.0
                  ),
                  child: const CircleAvatar(
                    // Tamaño reducido
                    radius: 50,
                    backgroundColor: Color(0XFF2CB7A6),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Campo de texto para el nombre de usuario (Username).
                TextFormField(
                  controller: _usernameController, // Asocia el controlador.
                  style: GoogleFonts.poppins(fontSize: 16.0, color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
                    hintText: 'Usuario',
                    contentPadding: const EdgeInsets.fromLTRB(
                      20.0,
                      15.0,
                      20.0,
                      15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: const BorderSide(
                        color: Color(0XFF2CB7A6),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: const BorderSide(
                        color: Color(0XFF2CB7A6),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),

                // Campo de texto para la contraseña (Password).
                TextFormField(
                  controller: _passwordController, // Asocia el controlador.
                  obscureText: true, // Oculta el texto.
                  style: GoogleFonts.poppins(fontSize: 16.0, color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    hintText: 'Contraseña',
                    contentPadding: const EdgeInsets.fromLTRB(
                      20.0,
                      15.0,
                      20.0,
                      15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: const BorderSide(
                        color: Color(0XFF2CB7A6),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: const BorderSide(
                        color: Color(0XFF2CB7A6),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),

                // Botón de inicio de sesión (Login Button).
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF2CB7A6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Ahora puedes acceder al texto de los campos usando los controladores.
                    // final username = _usernameController.text;
                    // final password = _passwordController.text;
                    // print('Usuario: $username, Contraseña: $password');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text('INGRESAR'),
                ),
                const SizedBox(height: 16.0),

                // Fila para las opciones de "Recordar" y "Recuperar contraseña".
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value:
                              _rememberMe, // El valor se basa en la variable de estado.
                          onChanged: (value) {
                            // setState() notifica a Flutter que el estado ha cambiado,
                            // por lo que debe volver a dibujar el widget.
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: const Color(0XFF2CB7A6),
                        ),
                        Text(
                          'Recordar',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: Colors.grey,
                            ),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        textStyle: GoogleFonts.poppins(fontSize: 14.0),
                      ),
                      onPressed: () {},
                      child: const Text('Recuperar contraseña'),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // Sección para crear una nueva cuenta.
                Column(
                  children: [
                    Text(
                      '¿Todavía no tienes cuenta?',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        color: Colors.grey,
                        ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF2CB7A6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaRegistro(),
                          ),
                        );
                      },
                      child: const Text('CREAR CUENTA'),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // Sección de login social.
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "O",
                        style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 24.0),

                ElevatedButton.icon(
                  icon: Image.network(
                    'https://res.cloudinary.com/dfznn7pui/image/upload/v1760138499/google_wkaueo.png',
                    height: 24.0,
                  ),
                  label: const Text('Inicia sesión con Google'),
                  onPressed: () {
                    // TODO: Implementar la lógica de inicio de sesión con Google.
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.grey[200],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),

                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Es una buena práctica liberar los controladores cuando el widget se destruye
  // para evitar fugas de memoria.
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
