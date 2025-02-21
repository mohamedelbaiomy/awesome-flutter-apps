import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String _userId = "";
  /*late Future<String> documentId;*/
  late String docId;
  String get getData {
    return _userId;
  }

  Future<void> setCustomerId(User user) async {
    final SharedPreferences pref = await _prefs;
    pref.setString('userid', user.uid).whenComplete(() => _userId = user.uid);
    notifyListeners();
  }

  Future<void> clearCustomerId() async {
    final SharedPreferences pref = await _prefs;
    pref.setString('userid', '').whenComplete(() => _userId = '');
    notifyListeners();
  }

  Future<String> getDocumentId() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString('userid') ?? '';
    });
  }

  Future<void> getDocId() async {
    await getDocumentId().then((value) => _userId = value);
    notifyListeners();
  }
}
