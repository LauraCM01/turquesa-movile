// Importa la biblioteca principal de Material Design de Flutter.
import 'package:flutter/material.dart';

// Define la clase LoginPage, que es un widget sin estado (StatelessWidget).
// Esto significa que su apariencia y comportamiento no cambian con el tiempo o la interacción del usuario.
class LoginPage extends StatelessWidget {
  // El constructor constante mejora el rendimiento.
  const LoginPage({super.key});

  @override
  // El método build es el corazón de cualquier widget.
  // Dibuja la interfaz de usuario en la pantalla y se llama cada vez que Flutter necesita renderizar el widget.
  Widget build(BuildContext context) {
    // Scaffold es como un andamio para construir una pantalla de Material Design.
    // Proporciona una estructura básica con appBar, body, floatingActionButton, etc.
    return Scaffold(
      // Define el color de fondo de toda la pantalla.
      backgroundColor: Colors.white,
      // SafeArea es un widget crucial que ajusta su contenido para evitar que se superponga
      // con elementos del sistema operativo, como la barra de estado superior o el "notch" en algunos teléfonos.
      body: SafeArea(
        // SingleChildScrollView permite que su contenido sea desplazable verticalmente
        // si el espacio de la pantalla no es suficiente. Esto evita errores de desbordamiento (overflow).
        child: SingleChildScrollView(
          // Padding añade un espacio vacío alrededor de su widget hijo.
          child: Padding(
            // EdgeInsets.symmetric crea un padding igual en los lados horizontales.
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            // Column organiza a sus hijos en una lista vertical. Es uno de los widgets de layout más comunes.
            child: Column(
              // mainAxisAlignment alinea a los hijos a lo largo del eje principal (vertical para Column).
              // .center los coloca en el medio.
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment alinea a los hijos a lo largo del eje transversal (horizontal para Column).
              // .stretch hace que los hijos ocupen todo el ancho disponible.
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // 'children' es la lista de widgets que se mostrarán dentro de la columna.
              children: <Widget>[
                // SizedBox es una caja con un tamaño específico. Se usa comúnmente para crear espacios vacíos.
                const SizedBox(height: 60.0),

                // Logo de la aplicación.
                const CircleAvatar(
                  radius: 70, // Define el radio del círculo.
                  backgroundColor: Color(
                    0XFF2CB7A6,
                  ), // Color de fondo del círculo (teal).
                  // El 'child' es el widget que va dentro del CircleAvatar.
                  child: Icon(
                    Icons.person,
                    size: 80, // Tamaño del ícono.
                    color: Colors.white, // Color del ícono.
                  ),
                ),
                const SizedBox(height: 48.0), // Espacio vertical.
                // Campo de texto para el nombre de usuario (Username).
                TextFormField(
                  initialValue: 'Nombre de usuario',
                  // 'style' controla la apariencia del texto que el usuario escribe.
                  style: const TextStyle(
                    fontSize:
                        18.0, // <-- Cambia el tamaño del texto de entrada aquí.
                    color: Colors
                        .black, // Puedes añadir otros estilos, como el color.
                  ),
                  // 'decoration' personaliza la apariencia del campo de texto.
                  decoration: InputDecoration(
                    // 'hintStyle' controla la apariencia del texto de sugerencia.
                    hintStyle: const TextStyle(
                      fontSize:
                          16.0, // <-- Cambia el tamaño del texto de sugerencia aquí.
                    ),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
                    hintText:
                        'Usuario', // Texto de sugerencia que aparece cuando el campo está vacío.
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
                  initialValue: '*********',
                  obscureText:
                      true, // Oculta el texto ingresado, ideal para contraseñas.
                  // 'style' controla la apariencia del texto que el usuario escribe.
                  style: const TextStyle(
                    fontSize:
                        18.0, // <-- Cambia el tamaño del texto de entrada aquí.
                    color: Colors
                        .black, // Puedes añadir otros estilos, como el color.
                  ),
                  decoration: InputDecoration(
                    // 'hintStyle' controla la apariencia del texto de sugerencia.
                    hintStyle: const TextStyle(
                      fontSize:
                          16.0, // <-- Cambia el tamaño del texto de sugerencia aquí.
                    ),
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
                  // 'style' personaliza la apariencia del botón.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF2CB7A6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    // --- AQUÍ SE CONTROLA EL ESTILO DEL TEXTO DEL BOTÓN ---
                    // 'textStyle' define la apariencia del widget de texto hijo del botón.
                    textStyle: const TextStyle(
                      fontSize:
                          20, // <-- Puedes cambiar el tamaño de la fuente aquí.
                      fontWeight: FontWeight
                          .bold, // <-- Y también otras propiedades como el peso de la fuente.
                    ),
                  ),
                  onPressed:
                      () {}, // La función que se ejecuta al presionar el botón (actualmente vacía).
                  child: const Text('INGRESAR'),
                ),
                const SizedBox(height: 16.0),

                // Fila para las opciones de "Recordar" y "Recuperar contraseña".
                // Row organiza a sus hijos en una lista horizontal.
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distribuye el espacio entre los hijos.
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: const Color(0XFF2CB7A6),
                        ),
                        const Text(
                          'Recordar',
                          // Para cambiar el tamaño, modifica el fontSize.
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        textStyle: const TextStyle(
                          fontSize: 16.0, // <-- Tamaño de la fuente.
                        ),
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
                    const Text(
                      '¿Todavía no tienes cuenta?',
                      // Para cambiar el tamaño, modifica el fontSize.
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ), // Espacio entre el texto y el nuevo botón.
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
                        textStyle: const TextStyle(
                          fontSize:
                              18, // Tamaño de fuente ligeramente más pequeño que el principal.
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('CREAR CUENTA'),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // --- SECCIÓN DE LOGIN SOCIAL ---
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "O",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                  ],
                ),
                const SizedBox(height: 24.0),

                ElevatedButton.icon(
                  icon: Image.network(
                    'https://res.cloudinary.com/dfznn7pui/image/upload/v1760138499/google_wkaueo.png', // <-- AQUÍ PUEDES PONER TU URL para el ícono del botón
                    height: 24.0,
                  ),
                  label: const Text('Inicia sesión con Google'),
                  onPressed: () {
                    // TODO: Implementar la lógica de inicio de sesión con Google.
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.grey[200],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),

                // Logo inferior de la marca.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.house_outlined,
                      color: Color(0XFF2CB7A6),
                      size: 40,
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TURQUESA',
                          style: TextStyle(
                            color: Color(0XFF2CB7A6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'HOSTAL',
                          style: TextStyle(
                            color: Color(0XFF2CB7A6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
