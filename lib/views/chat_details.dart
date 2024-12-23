import 'package:flutter/material.dart';

class ChatDetails extends StatelessWidget {
  final String name;
  final String image;
  final String message;
  final String date;
  const ChatDetails({
    super.key,
    required this.name,
    required this.image,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 20,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            Text(name),
          ],
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text(message),
            Text(date),
          ],
        ),
      ),
    );
  }
}
