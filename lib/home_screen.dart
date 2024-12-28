import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'contact_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int selectedIndex = -1;
  List<Contact> contactList = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? contactsJson = prefs.getString('contacts');
    if (contactsJson != null) {
      List<dynamic> contactsList = json.decode(contactsJson);
      setState(() {
        contactList =
            contactsList.map((item) => Contact.fromJson(item)).toList();
      });
    }
  }

  Future<void> saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String contactsJson =
        json.encode(contactList.map((contact) => contact.toJson()).toList());
    await prefs.setString('contacts', contactsJson);
  }

  void addContact(String name, String phone) {
    setState(() {
      contactList.add(Contact(name: name, phone: phone));
      saveContacts();
    });
  }

  void updateContact(String name, String phone) {
    setState(() {
      if (selectedIndex != -1) {
        contactList[selectedIndex].name = name;
        contactList[selectedIndex].phone = phone;
        selectedIndex = -1;
        saveContacts();
      }
    });
  }

  void deleteContact(int index) {
    setState(() {
      contactList.removeAt(index);
      saveContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
        focusNode2.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contacts List"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  contactList.clear();
                  saveContacts();
                });
              },
              icon: Icon(Icons.delete_forever),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 30,
            children: [
              TextFormField(
                controller: nameController,
                focusNode: focusNode1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must enter the name';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white70,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white70,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                ),
              ),
              TextFormField(
                controller: phoneController,
                focusNode: focusNode2,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must enter the phone';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Number',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white70,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white70,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                      String name = nameController.text.trim();
                      String phone = phoneController.text.trim();
                      if (selectedIndex == -1) {
                        addContact(name, phone);
                      } else {
                        updateContact(name, phone);
                      }
                      nameController.clear();
                      phoneController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(selectedIndex == -1 ? "Save" : "Update"),
                  ),
                ],
              ),
              Expanded(
                child: contactList.isEmpty
                    ? Center(
                        child: Text(
                          "No Contacts yet .. !",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 23,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: contactList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: customListTile(index: index),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile({required int index}) {
    return ListTile(
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white70,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          contactList[index].name[0],
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      title: Text(
        contactList[index].name,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      subtitle: Text(
        contactList[index].phone,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  nameController.text = contactList[index].name;
                  phoneController.text = contactList[index].phone;
                  selectedIndex = index;
                });
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                deleteContact(index);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
