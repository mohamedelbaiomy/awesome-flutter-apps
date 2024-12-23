import 'package:basketball_counter/basketball_counter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Basket Ball',
      debugShowCheckedModeBanner: false,
      home: BasketBall(),
    );
  }
}
