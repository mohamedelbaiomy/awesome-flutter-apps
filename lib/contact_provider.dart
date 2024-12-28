import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'contact_model.dart';

class ContactProvider extends ChangeNotifier {
  int selectedIndex = -1;
  List<Contact> contactList = [];

  ContactProvider() {
    loadContacts();
  }

  void changeSelectedIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Future<void> loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? contactsJson = prefs.getString('contacts');
    if (contactsJson != null) {
      List<dynamic> contactsList = json.decode(contactsJson);
      contactList = contactsList.map((item) => Contact.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String contactsJson =
        json.encode(contactList.map((contact) => contact.toJson()).toList());
    await prefs.setString('contacts', contactsJson);
  }

  void addContact(String name, String phone) {
    contactList.add(Contact(name: name, phone: phone));
    saveContacts();
    notifyListeners();
  }

  void updateContact(int index, String name, String phone) {
    if (index >= 0 && index < contactList.length) {
      contactList[index].name = name;
      contactList[index].phone = phone;
      saveContacts();
      notifyListeners();
    }
  }

  void deleteContact(int index) {
    if (index >= 0 && index < contactList.length) {
      contactList.removeAt(index);
      saveContacts();
      notifyListeners();
    }
  }

  void clearContacts() {
    contactList.clear();
    saveContacts();
    notifyListeners();
  }
}
