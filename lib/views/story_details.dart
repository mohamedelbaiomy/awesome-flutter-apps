import 'package:flutter/material.dart';

class StoryDetails extends StatelessWidget {
  final String image;
  final String name;
  const StoryDetails({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            height: 300,
            width: 300,
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
