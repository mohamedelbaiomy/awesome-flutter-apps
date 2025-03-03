import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  late SharedPreferences storage;

  changeTheme() {
    _isDark = !_isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? true;
    notifyListeners();
  }

  final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    secondaryHeaderColor: Colors.white70,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.white12,
    indicatorColor: Colors.white54,
    shadowColor: Colors.white60,
    canvasColor: Colors.black26,
    unselectedWidgetColor: Colors.white38,
  );

  final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    secondaryHeaderColor: Colors.black87,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.black26,
    indicatorColor: Colors.black45,
    shadowColor: Colors.black38,
    canvasColor: Colors.white12,
    unselectedWidgetColor: Colors.black26,
  );
}
