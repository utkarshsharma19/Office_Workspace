import 'package:office_spacez/modules/booking_cafeteria/api/api.dart';

import '../../../utils/user_state.dart';

class MeetingRoomRepository {
  // final api = API();

  Future<int?> confirmPostCallback(
    String date,
    String start_time,
    String end_time,
    // String room_id,
    // String room_name,
    String token,
    // num floo
  ) async {
    final payload = {
      // Define your payload here
      "date": date,
      "start_time": start_time,
      "end_time": end_time,
      // "room_id": room_id,
      // "room_name": room_name,
      "token": token,
      // "floor": floor
    };
    String jwtToken = await getUserToken();

    final headers = {"Authorization": "Bearer ${jwtToken}"};

    try {
      final response = await DioClient.postRequest(
          'http://localhost:8080/cafeteria-booking', headers, payload);
      // final responseData = response.data;
      print("this is the status code ---------->");
      print(response.statusCode?.toInt());
      // print()
      return response.statusCode?.toInt();
    } catch (error, stacktrace) {
      print('Error: $error stacktrace: $stacktrace');
    }
  }
}
