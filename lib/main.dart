import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/sqlhelper.dart';
import 'views/home_screen.dart';
import 'logic/notes_todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SQLHelper().getDatabase();
  runApp(
    ChangeNotifierProvider(
      create: (_) => DatabaseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes & Todo',
      home: const MyHomePage(),
    );
  }
}

