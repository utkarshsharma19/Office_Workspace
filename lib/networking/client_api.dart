// import 'dart:ffi';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:office_spacez/utils/user_state.dart';

final Dio _dio = Dio();
const String base_url = 'http://localhost:8080';

enum HttpType { GET, PUT, POST, DELETE }

enum RespCode {
  OK(200),
  BAD_REQ(400),
  UNAUTHORIZED_ACCESS(401),
  NOT_FOUND(404),
  NO_NET(503),
  TIMEOUT(504),
  UNKNOWN(-1);

  const RespCode(this.value);
  final int value;

  static RespCode getByValue(int val) {
    return RespCode.values.firstWhere(
        (x) => (x.value <= val) && (x.value > (val - 100)),
        orElse: () => RespCode.UNKNOWN);
  }
}

Future<Map<String, dynamic>> getRespFromServer({
  required String endpoint,
  required HttpType req,
  Map<String, dynamic>? params,
}) async {
  await Future.delayed(const Duration(seconds: 2)); // Proxy delay for localhost
  Map<String, dynamic> respData = {};

  final token = await getUserToken();
  print("-------------------------inside common client: $token");
  final headers = {'Authorization': 'Bearer $token'};
  if (token.isEmpty) {
    respData["code"] = RespCode.UNAUTHORIZED_ACCESS;
    return respData;
  }

  try {
    Response response;
    var query = "$base_url/$endpoint";
    switch (req) {
      case HttpType.GET:
        response = await _dio.get(query,
            queryParameters: params, options: Options(headers: headers));
        break;
      case HttpType.POST:
        response = await _dio.post(query,
            data: params, options: Options(headers: headers));
        break;
      default:
        // Shouldn't reach here
        response = Response(requestOptions: RequestOptions());
        break;
    }
    print("Response: ${response.data}"); // Debug
    respData["code"] = response.statusCode;
    switch (RespCode.getByValue(response.statusCode ?? -1)) {
      case RespCode.OK:
      case RespCode.BAD_REQ:
      case RespCode.NOT_FOUND:
        respData["data"] = response
            .data; // Return map of response. Response data is expected to be in json format
        break;
      default:
        respData["data"] = null; // Need update?
        break;
    }
  } catch (error, stacktrace) {
    // Unexpected Error
    print("Exception occured: $error stackTrace: $stacktrace"); // Debug
    respData["data"] = null;
  }
  return respData;
}


// @immutable
// abstract class HttpState {}

// class NoReq extends HttpState {}
// class StartReq extends HttpState {}
// class ReqInProgress extends HttpState {}
// class ReqSuccess extends HttpState {}
// class ReqError extends HttpState {}

