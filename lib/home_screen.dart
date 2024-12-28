import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode1 = FocusNode();
    FocusNode focusNode2 = FocusNode();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
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
                  contactProvider.clearContacts();
                },
                icon: Icon(Icons.delete_forever),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
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
                    decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person, color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 1, color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 2, color: Colors.white70),
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
                    decoration: InputDecoration(
                      hintText: 'Number',
                      prefixIcon: Icon(Icons.numbers, color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 1, color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 2, color: Colors.white70),
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
                          if (formKey.currentState!.validate()) {
                            String name = nameController.text.trim();
                            String phone = phoneController.text.trim();
                            if (contactProvider.selectedIndex == -1) {
                              contactProvider.addContact(name, phone);
                            } else {
                              contactProvider.updateContact(
                                contactProvider.selectedIndex,
                                name,
                                phone,
                              );
                              contactProvider.changeSelectedIndex(-1);
                            }
                            nameController.clear();
                            phoneController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          foregroundColor: Colors.black,
                        ),
                        child: Text(
                          contactProvider.selectedIndex == -1
                              ? "Save"
                              : "Update",
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: contactProvider.contactList.isEmpty
                        ? Center(
                            child: Text(
                              "No Contacts yet .. !",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 23),
                            ),
                          )
                        : ListView.builder(
                            itemCount: contactProvider.contactList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  shape: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white70,
                                    child: Text(
                                      contactProvider
                                          .contactList[index].name[0],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  title: Text(
                                    contactProvider.contactList[index].name,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    contactProvider.contactList[index].phone,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            nameController.text =
                                                contactProvider
                                                    .contactList[index].name;
                                            phoneController.text =
                                                contactProvider
                                                    .contactList[index].phone;
                                            contactProvider
                                                .changeSelectedIndex(index);
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            contactProvider
                                                .deleteContact(index);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
