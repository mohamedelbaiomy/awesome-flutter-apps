import 'package:change_theme_example/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';

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
      create: (_) => ThemeProvider()..init(),
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: themeProvider.isDark
              ? themeProvider.darkTheme
              : themeProvider.lightTheme,
          theme: themeProvider.isDark
              ? themeProvider.darkTheme
              : themeProvider.lightTheme,
          title: 'Change Mode',
          debugShowCheckedModeBanner: false,
          home: Home(),
        );
      }),
    );
  }
}
