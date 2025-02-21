import 'package:flutter/material.dart';

class ScreenIndexProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get currentIndex => _selectedIndex;

  void updateScreenIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}
