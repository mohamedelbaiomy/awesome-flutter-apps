import 'package:flutter/material.dart';
import 'package:weather_app/constant.dart';

class ErrorScreen extends StatelessWidget {
  final Function() onTryAgainPressed;
  final String buttonTitle;
  const ErrorScreen({
    super.key,
    required this.onTryAgainPressed,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onTryAgainPressed,
              child: Text(
                buttonTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
