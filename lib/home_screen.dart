import 'dart:math';

import 'package:bmi_body_mass_index_calculator/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender {
  male,
  female,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gender person = Gender.male;
  double height = 10;
  int weight = 30;
  int age = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          person = Gender.male;
                        });
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: person == Gender.male
                              ? Colors.white38
                              : Colors.white12,
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.male,
                              size: 100,
                              color: Colors.white70,
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          person = Gender.female;
                        });
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: person == Gender.female
                              ? Colors.white38
                              : Colors.white12,
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.female,
                              size: 100,
                              color: Colors.white70,
                            ),
                            Text(
                              "Female",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white12,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Height",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "${height.toInt()}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                    ),
                    Slider(
                      value: height,
                      min: 0,
                      max: 500,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Weight",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "$weight",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 30,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white24,
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.plus_one),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white24,
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.exposure_minus_1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Age",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "$age",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 30,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white24,
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.plus_one),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white24,
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.exposure_minus_1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  double result = weight / pow(height / 100, 2);
                  Get.to(
                    ResultScreen(result: result),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  "Calculate",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
