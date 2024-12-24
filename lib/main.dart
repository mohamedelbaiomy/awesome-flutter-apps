import 'package:flutter/material.dart';
import 'package:notes_app/sql_helper.dart';


import 'notes_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SqlHelper().getDatabase();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}
