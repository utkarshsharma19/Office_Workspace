// import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:office_spacez/networking/client_api.dart';
import 'package:office_spacez/utils/user_state.dart';

Future<int?> fetchUserInfo(String email, String password, String token) async {
  final Dio _dio = Dio();
  const String _url = "http://localhost:8080/auth/login";

  try {
    Response response = await _dio.post(_url,
        data: {"email": email, "password": password, "firebaseToken": token});
    print("Response: ${response.data}");
    if (RespCode.getByValue(response.statusCode!) == RespCode.OK) {
      // print(response.data["token"]);
      setUserInfo(
          email: response.data["email"],
          role: response.data["role"],
          token: response.data["token"]);
    }
    return response.statusCode;
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    // return ["Data not found / Connection issue"];
  }
}
