import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class Arabic extends StatefulWidget {
  const Arabic({super.key});

  @override
  State<Arabic> createState() => _ArabicState();
}

class _ArabicState extends State<Arabic> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      changeLanguage();
      Restart.restartApp();
    });
  }

  changeLanguage() {
    context.setLocale(Locale("ar"));
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
              "انتظر بينما يتم اعداد اللغة العربية",
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
