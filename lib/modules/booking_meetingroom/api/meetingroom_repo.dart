import 'package:office_spacez/modules/booking_meetingroom/api/api.dart';
import 'package:office_spacez/modules/booking_meetingroom/models/booking_room_model.dart';

class MeetingRoomRepository {
  // final api = API();

  Future<int?> confirmationPostCallback(
      String date,
      String start_time,
      String end_time,
      String room_id,
      String room_name,
      num userID,
      num floor) async {
    final payload = {
      // Define your payload here
      "date": date,
      "start_time": start_time,
      "end_time": end_time,
      "room_id": room_id,
      "room_name": room_name,
      "userID": userID,
      "floor": floor
    };

    try {
      final response = await DioClient.postRequest(
          'http://localhost:8080/meetingroom-booking', payload);
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
