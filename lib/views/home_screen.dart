import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_provider/views/city_name/views/get_city.dart';
import 'package:weather_api_provider/views/user_location/provider/user_location_provider.dart';
import 'package:weather_api_provider/views/user_location/views/user_location.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3A3F54),
      appBar: AppBar(
        backgroundColor: const Color(0xff3A3F54),
        title: const Text(
          "Weather App",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          ChangeNotifierProvider(
                            create: (context) => UserLocationProvider(),
                            child: UserLocation(),
                          ),
                          transition: Transition.rightToLeftWithFade,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 150,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "Current\nLocation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          const GetCity(),
                          transition: Transition.fadeIn,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 150,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "City\nName",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
