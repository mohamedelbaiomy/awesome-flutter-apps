import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class English extends StatefulWidget {
  const English({super.key});

  @override
  State<English> createState() => _EnglishState();
}

class _EnglishState extends State<English> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      changeLanguage();
      Restart.restartApp();
    });
  }

  changeLanguage() {
    context.setLocale(Locale("en"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 35,
          children: [
            Text(
              "Wait while setting up English",
              style: TextStyle(fontSize: 25),
            ),
            CircularProgressIndicator(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
