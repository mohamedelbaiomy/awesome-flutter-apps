import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_app/views/home_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

/// Api Link :  https://api.nstack.in/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
