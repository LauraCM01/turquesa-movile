
# Blueprint: Reservation App

## Overview

This document outlines the plan for creating a reservation form in a Flutter application.

## Implemented Features

*   **Reservation Form Screen:**
    *   Created and styled the reservation form.
    *   Allowed manual input for date fields.
*   **Dependencies:**
    *   Added `intl` for date formatting.
    *   Added `google_fonts` for typography.
*   **Theming:**
    *   Centralized application styles in `lib/app_theme.dart`.

## Current Goal

Implement the main navigation structure with a `BottomNavigationBar`.

### Plan

1.  **Create Placeholder Screens:**
    *   Create `lib/screens/home_screen.dart`.
    *   Create `lib/screens/chat_screen.dart`.
    *   Create `lib/screens/profile_screen.dart`.
2.  **Refactor Reservation Form:**
    *   Move the `ReservationForm` widget into its own file: `lib/widgets/reservation_form.dart`.
    *   Integrate the `ReservationForm` into the `HomeScreen`.
3.  **Create Main Navigation Widget:**
    *   Create `lib/main_screen.dart` to act as the main app shell.
    *   This widget will be a `StatefulWidget` containing a `Scaffold` with a `BottomNavigationBar`.
    *   The body of the `Scaffold` will display the selected screen (Home, Chat, or Profile).
4.  **Update `main.dart`:**
    *   Set the `home` property of `MaterialApp` to the new `MainScreen`.
5.  **Fix Navigation Bar Visibility:**
    *   Add a background color to the `BottomAppBarTheme` in `app_theme.dart` to ensure it is visible.
