import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:todo_api_provider/provider/request_provider.dart';
import 'package:todo_api_provider/views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RequestProvider()),
      ],
      child: const MyApp(),
    ),
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
