import 'package:firebase_example/core/providers/add_event_provider.dart';
import 'package:firebase_example/core/providers/id_provider.dart';
import 'package:firebase_example/core/providers/screen_index_provider.dart';
import 'package:firebase_example/features/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'core/providers/read_events_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventsProvider()),
        ChangeNotifierProvider(create: (_) => IdProvider()),
        ChangeNotifierProvider(create: (_) => ScreenIndexProvider()),
        ChangeNotifierProvider(create: (_) => AddEventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Firebase Example',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
