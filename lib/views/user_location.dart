import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/model/user_location_model.dart';
import 'package:weather_app/views/error_screen.dart';
import 'package:weather_app/views/loading_screen.dart';
import '../helpers/api_helper.dart';
import '../helpers/location_helper.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  ApiState state = ApiState.loading;
  WeatherDataModel? weatherDataModel;

  Future<void> getLocationAndWeatherData() async {
    try {
      setState(() {
        state = ApiState.loading;
      });
      Position position = await LocationHelper.determinePosition();
      Map<String, dynamic> weatherData = await ApiHelper.getData(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey',
      );
      setState(() {
        state = ApiState.success;
        weatherDataModel = WeatherDataModel.fromMap(weatherData);
      });
    } catch (e) {
      setState(() {
        state = ApiState.error;
      });
      Flushbar(
        message: e.toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 2),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
    }
  }

  String getWeatherIconFromCondition(int condition) {
    if (condition <= 232) {
      return 'assets/images/thunder.png';
    } else if (condition <= 321) {
      return 'assets/images/drizzle.png';
    } else if (condition <= 531) {
      return 'assets/images/rain.png';
    } else if (condition <= 622) {
      return 'assets/images/snow.png';
    } else if (condition <= 781) {
      return 'assets/images/tornado.png';
    } else if (condition == 800) {
      return 'assets/images/clear.png';
    } else {
      return 'assets/images/cloudy.png';
    }
  }

  String getMessageFromTemperature(int temp) {
    if (temp < 25) {
      return "It's 🍦 Time";
    } else if (temp > 20) {
      return "Time for shorts 🩳";
    } else if (temp < 10) {
      return "Time for Jackets";
    } else {
      return "Bring a Coat";
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationAndWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return state == ApiState.loading
        ? const LoadingScreen()
        : state == ApiState.error
            ? ErrorScreen(
                onTryAgainPressed: () {
                  getLocationAndWeatherData();
                },
                buttonTitle: 'Try Again',
              )
            : Scaffold(
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
                        "${weatherDataModel!.name}",
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
                            "${(weatherDataModel!.main!.temp! - 272.15).toInt()} °",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontSize: 90,
                            ),
                          ),
                          Image.asset(
                            getWeatherIconFromCondition(
                              weatherDataModel!.weather![0].id!,
                            ),
                            height: 90,
                            width: 90,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        "${weatherDataModel!.weather![0].main} in ${weatherDataModel!.sys!.country}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Lat : ${weatherDataModel!.coord!.lat} - Lon : ${weatherDataModel!.coord!.lon}",
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
                                weatherDataModel!.wind!.speed.toString(),
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
                                "Visibilty",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                weatherDataModel!.visibility.toString(),
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
                                "Humadity",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                weatherDataModel!.main!.humidity.toString(),
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
                        getMessageFromTemperature(
                          (weatherDataModel!.main!.temp! - 272.15).toInt(),
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
  }
}
