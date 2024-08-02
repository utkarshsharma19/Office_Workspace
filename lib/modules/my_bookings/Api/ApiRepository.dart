import 'package:office_spacez/modules/my_bookings/model/MeetingModel.dart';
import 'package:office_spacez/modules/my_bookings/model/cafeteria_model.dart';
import 'package:office_spacez/modules/my_bookings/model/seating_model.dart';
// import '../model/meetingroom_bookings_model.dart';
import 'ApiProvider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<MeetingModel> fetchMeeting() {
    return _provider.fetchMeeting();
  }




// Future<List<MeetingRoomBookings>> fetchMeetings() {
//     return _provider.fetchMeetings();
//   }
  Future<SeatingModel> fetchSeating() {
    return _provider.fetchSeating();
  }

  Future<CafeteriaModel> fetchCafeteria() {
    return _provider.fetchCafeteria();
  }
}

class NetworkError extends Error {}