# Blueprint

## Visión General

Esta aplicación es una interfaz de chat diseñada para una comunicación clara y moderna, siguiendo el diseño proporcionado.

## Diseño y Características

*   **Paleta de Colores:** Verde azulado primario para mensajes enviados y acentos, gris claro para mensajes recibidos y un fondo de pantalla azul pálido.
*   **Tipografía:** Fuente sans-serif limpia y legible.
*   **Barra de Aplicación (App Bar):** Título "Administrador" con un botón de retroceso.
*   **Vista de Mensajes:** Una lista de burbujas de chat.
    *   **Burbujas de Mensajes Enviados:** Color verde azulado, alineadas a la derecha, con una cola en la esquina inferior derecha.
    *   **Burbujas de Mensajes Recibidos:** Color gris claro, alineadas a la izquierda, con una cola en la esquina inferior izquierda.
*   **Campo de Entrada:** Un campo de texto redondeado con el texto de marcador de posición "Escribir..." y un botón de enviar circular con un icono de flecha.

## Estructura del Proyecto

*   `lib/main.dart`: El punto de entrada principal de la aplicación.
*   `lib/home_screen.dart`: Contiene la pantalla de chat principal.
*   `lib/message_buble.dart`: Contiene el widget de la burbuja de chat.

## Plan Actual

1.  **Refactorizar la Base del Código:**
    *   Mover la pantalla de chat a su propio archivo (`lib/home_screen.dart`).
    *   Mover el widget de la burbuja de chat a su propio archivo (`lib/message_buble.dart`).
    *   Actualizar `lib/main.dart` para usar la nueva estructura de archivos.
