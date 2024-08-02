// import 'package:dio/dio.dart';
// import 'package:office_spacez/modules/booking_meetingroom/models/booking_room_model.dart';

// class API {
//   final Dio _dio = Dio();
//   final String _url =
//       "http://172.16.27.23/meetingroom-booking/getAvailableRoomNames";

//   Future<List<dynamic>> fetchMeetingRoomsByCapacity(
//       String date, String start_time, String end_time, int capacity) async {
//     Map<String, dynamic> payload = {
//       "date": date,
//       "start_time": start_time,
//       "end_time": end_time,
//       "capacity": capacity
//     };
//     try {
//       Response res = await _dio.post(_url, data: payload);
//       print("IN DS");
//       print(res);

//       // return NewsModel.fromJson(res.data);
//       //  List result = jsonDecode(res.body)
//       List<dynamic> bookings = res.data;
//       return bookings
//           .map((newsInstance) => BookingRoomModel.fromJson(newsInstance))
//           .toList();
//       // return
//     } catch (error) {
//       print(error);
//     }
//     return [];
//   }
// }

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
