import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_provider/views/city_name/provider/city_name_provider.dart';
import '../../../constant.dart';
import '../../error_screen.dart';
import '../../loading_screen.dart';

class CityName extends StatelessWidget {
  final String cityName;
  const CityName({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    context.read<CityNameProvider>().fetchWeatherData(cityName, context);

    return Consumer<CityNameProvider>(
      builder: (context, provider, child) {
        if (provider.state == ApiState.loading) {
          return const LoadingScreen();
        } else if (provider.state == ApiState.error) {
          return ErrorScreen(
            onTryAgainPressed: () {
              provider.fetchWeatherData(cityName, context);
            },
            buttonTitle: 'Try Again',
          );
        }

        return Scaffold(
          backgroundColor: scaffoldColor,
          appBar: AppBar(
            backgroundColor: scaffoldColor,
            centerTitle: true,
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
            title: const Text(
              "Get Weather by City Name",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
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
