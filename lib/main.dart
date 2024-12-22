import 'package:flutter/material.dart';
import 'package:gdg_benha/home.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDG Benha',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
