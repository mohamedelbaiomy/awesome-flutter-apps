import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'business_card.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_outlined,
                  size: 100,
                  color: Colors.red,
                ),
                const SizedBox(height: 25),
                Text(
                  kDebugMode
                      ? errorDetails.exception.toString()
                      : "Something went wrong",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Card',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const BusinessCard(),
    );
  }
}
