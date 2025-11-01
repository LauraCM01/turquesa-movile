import 'package:flutter/material.dart';
import 'package:myapp/Inicio-App.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/room_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//void main() => runApp(const Inicio());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      // 2. Creas una instancia de tu RoomProvider.
      create: (context) => RoomProvider(),
      // 3. El resto de tu aplicación es ahora un "hijo" del Provider.
      child: const Inicio(),
    ),
  );
}
