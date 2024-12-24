import 'package:dio/dio.dart';

class ApiHelper {
  static Dio dio = Dio();
  static Future<Map<String, dynamic>> getData({required String url}) async {
    Response response = await dio.get(url);
    Map<String, dynamic> weatherData = response.data;
    return weatherData;
  }
}
