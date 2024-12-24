import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_api_provider/constant.dart';
import 'package:weather_api_provider/model/user_location_model.dart';
import '../../../helpers/api_helper.dart';
import '../../../helpers/location_helper.dart';

class UserLocationProvider with ChangeNotifier {
  ApiState state = ApiState.loading;
  WeatherDataModel? weatherDataModel;

  Future<void> fetchWeatherData(BuildContext context) async {
    try {
      state = ApiState.loading;
      notifyListeners();

      Position position = await LocationHelper.determinePosition();
      Map<String, dynamic> weatherData = await ApiHelper.getData(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey',
      );

      weatherDataModel = WeatherDataModel.fromMap(weatherData);
      state = ApiState.success;
      notifyListeners();
    } catch (e) {
      state = ApiState.error;
      notifyListeners();

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
    notifyListeners();
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
}
