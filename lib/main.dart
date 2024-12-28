import 'package:contacts_app_provider/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MaterialApp(
        title: 'Contacts app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
