import 'package:flutter/material.dart';

class BasketBall extends StatefulWidget {
  const BasketBall({super.key});

  @override
  State<BasketBall> createState() => _BasketBallState();
}

class _BasketBallState extends State<BasketBall> {
  int teamAPoints = 0;
  int teamBPoints = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("BasketBall Counter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Team A",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      teamAPoints.toString(),
                      style: const TextStyle(
                        fontSize: 80,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          teamAPoints += 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Add 1 Point",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          teamAPoints += 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Add 2 Points",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          teamAPoints += 3;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Add 3 Points",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200,
                  child: VerticalDivider(
                    width: 1,
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Team B",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      teamBPoints.toString(),
                      style: const TextStyle(
                        fontSize: 80,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          teamBPoints += 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Add 1 Point",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          teamBPoints += 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Add 2 Points",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          teamBPoints += 3;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Add 3 Points",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  teamBPoints = 0;
                  teamAPoints = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 40),
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
