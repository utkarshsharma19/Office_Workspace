import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Future<Response> postRequest(
      String url, Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post(url, data: payload);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
