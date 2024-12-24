import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_provider/views/error_screen.dart';
import 'package:weather_api_provider/views/loading_screen.dart';
import 'package:weather_api_provider/views/user_location/provider/user_location_provider.dart';

import '../../../constant.dart';

class UserLocation extends StatelessWidget {
  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<UserLocationProvider>().state == ApiState.loading) {
      context.read<UserLocationProvider>().fetchWeatherData(context);
    }

    return Consumer<UserLocationProvider>(
      builder: (context, provider, child) {
        if (provider.state == ApiState.loading) {
          return const LoadingScreen();
        } else if (provider.state == ApiState.error) {
          return ErrorScreen(
            onTryAgainPressed: () {
              provider.fetchWeatherData(context);
            },
            buttonTitle: 'Try Again',
          );
        }

        return Scaffold(
          backgroundColor: scaffoldColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white70,
                size: 15,
              ),
            ),
            backgroundColor: scaffoldColor,
            title: const Text(
              "Get Weather by Location",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              spacing: 40,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Text(
                  "${provider.weatherDataModel!.name}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Row(
                  spacing: 25,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(provider.weatherDataModel!.main!.temp! - 272.15).toInt()} °",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.normal,
                        fontSize: 90,
                      ),
                    ),
                    Image.asset(
                      provider.getWeatherIconFromCondition(
                        provider.weatherDataModel!.weather![0].id!,
                      ),
                      height: 90,
                      width: 90,
                      color: Colors.white,
                    ),
                  ],
                ),
                Text(
                  "${provider.weatherDataModel!.weather![0].main} in ${provider.weatherDataModel!.sys!.country}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Lat : ${provider.weatherDataModel!.coord!.lat} - Lon : ${provider.weatherDataModel!.coord!.lon}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 25,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Wind Speed",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          provider.weatherDataModel!.wind!.speed.toString(),
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Visibility",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          provider.weatherDataModel!.visibility.toString(),
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Humidity",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          provider.weatherDataModel!.main!.humidity.toString(),
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  provider.getMessageFromTemperature(
                    (provider.weatherDataModel!.main!.temp! - 272.15).toInt(),
                  ),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
