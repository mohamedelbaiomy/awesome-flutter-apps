import 'package:dio/dio.dart';

class ApiHelper {
  static Dio dio = Dio();
  static Future<Map<String, dynamic>> getData(String url) async {
    Response response = await dio.get(url);
    Map<String, dynamic> todoData = response.data;
    return todoData;
  }

  static Future postData(String url, Map<String, dynamic> data) async {
    Response response = await dio.post(url, data: data);
    return response;
  }

  static Future deleteData(String id) async {
    Response response = await dio.delete("https://api.nstack.in/v1/todos/$id");
    return response;
  }

  static Future putData(String id, Map<String, dynamic> data) async {
    Response response =
        await dio.put("https://api.nstack.in/v1/todos/$id", data: data);
    return response;
  }
}
