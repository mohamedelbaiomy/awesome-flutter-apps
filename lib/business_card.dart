import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Business Card",
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: CircleAvatar(
                radius: 110,
                backgroundImage: AssetImage('images/1.png'),
              ),
            ),
          ),
          const SelectableText(
            "Mohamed Elbaiomy",
            style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Flutter Developer",
            style: TextStyle(
              letterSpacing: 1,
              color: Colors.white70,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 15),
          SelectionArea(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.call),
                  SizedBox(width: 20),
                  Text(
                    "01009429689",
                    style: TextStyle(
                      letterSpacing: 2,
                    ),
                  )
                ],
              ),
            ),
          ),
          SelectionContainer.disabled(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 20),
                  Text(
                    "mohamedelbaiomy262003@gmail.com",
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
