import 'dart:convert';

import 'package:dio/dio.dart';

// import 'package:http/http.dart' as http;
import 'package:office_spacez/modules/my_bookings/model/cafeteria_model.dart';
import 'package:office_spacez/modules/my_bookings/model/seating_model.dart';

import '../../../networking/client_api.dart';
import '../../../utils/user_state.dart';
import '../model/MeetingModel.dart';
// import '../model/meetingroom_bookings_model.dart';


class ApiProvider {

  

  Future<MeetingModel> fetchMeeting() async {

    String userId = await getUserEmail();
    String endpoint = '/meetingroom-booking/booking/${userId}';
    final response =  await getRespFromServer(endpoint: endpoint, req: HttpType.GET);
    if (response["code"] == 200) {
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return MeetingModel.fromJson(response['data']);
    } else {
      throw Exception('Failed to fetch booking');
    }
  }




// Future<List<MeetingRoomBookings>> fetchMeetings() async {

//     String userId = await getUserId();
//     String endpoint = 'meetingroom-booking/booking/$userId';
//     final response =  await getRespFromServer(endpoint: endpoint, req: HttpType.GET);;
//     if (response["code"] == 200) {
//       // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//       return meetingRoomBookingsFromJson(response['data']);
//     } else {
//       throw Exception('Failed to fetch booking');
//     }
//   }

  Future<SeatingModel> fetchSeating() async {
    String userId = await getUserEmail();
    String endpoint = 'seat-booking/booking/$userId';
    final response =  await getRespFromServer(endpoint: endpoint, req: HttpType.GET);
    if (response['code'] == 200) {
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return SeatingModel.fromJson(response['data']);
    } else {
      throw Exception('Failed to fetch booking');
    }
  }
  Future<CafeteriaModel> fetchCafeteria() async {
    String token = await getUserEmail();
    String endpoint = 'cafeteria-nbooking/booking/$token';
    final response = await getRespFromServer(endpoint: endpoint, req: HttpType.GET);
    if (response['code'] == 200) {
      // final Map<String, dynamic> jsonResponse = jsonDecode(response['data']);
      return CafeteriaModel.fromJson(response['data']);
    } else {
      throw Exception('Failed to fetch cafeteria');
    }
  }

}