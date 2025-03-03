import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization_example/features/languages/arabic.dart';
import 'package:localization_example/features/languages/english.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home").tr(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          spacing: 15,
          children: [
            SizedBox(height: 1),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 50),
            ).tr(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("العربية"),
              onTap: () {
                Get.to(
                  Arabic(),
                  transition: Transition.fadeIn,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("English"),
              onTap: () {
                Get.to(
                  English(),
                  transition: Transition.fadeIn,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
