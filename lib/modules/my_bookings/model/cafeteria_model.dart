
// class CafeteriaModel {
//   // final int id;
//   final int token;
//   final int bookingID;
//   // final int floor;
//   // final String amenity;
//   final String startTime;
//   final String endTime;
//   // final String meetingRoomId;
//   // final String meetingRoomName;
//   final String date;

//   CafeteriaModel({
//     // required  this.id,
//     // required this.userID,
//     required this.bookingID,
//     // required this.floor,
//     // required this.amenity,
//     required this.startTime,
//     required this.endTime,
//     // required this.meetingRoomId,
//     // required this.meetingRoomName,
//     required this.date,

//   });

//   factory CafeteriaModel.fromJson(Map<String, dynamic> json) {
//     return CafeteriaModel(
//       id: json['id'] as int,
//       userID: json['userID'] as int,
//       bookingID: json['bookingID'] as int,
//       floor: json['floor'] as int,
//       amenity: json['amenity'] as String,
//       startTime: json['start_time'] as String,
//       endTime: json['end_time'] as String,
//       meetingRoomId: json['meeting_room_id'] as String,
//       meetingRoomName: json['meeting_room_name'] as String,
//       date: json['date'] as String,
//     );
//   }
// /*{ "id": 4, "userID": 457689, "amenity": "Cafeteria Room", "bookingID": 5,
//   "start_time": "2023-05-22T08:58:06.403Z", "end_time": "2023-05-22T09:58:06.403Z",
//   "floor": 1, "meeting_room_id": "G1", "meeting_room_name": "Amex", "date": "2020–04–01 21:02:09.367"}*/

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userID': userID,
//       'bookingID': bookingID,
//       'floor': floor,
//       'amenity': amenity,
//       'start_time': startTime,
//       'end_time': endTime,
//       'meeting_room_id': meetingRoomId,
//       'meeting_room_name': meetingRoomName,
//       'date': date,
//     };
//   }
// }



class CafeteriaModel {
  CafeteriaModel({
    required this.cafeteriaData,
  });
  late final List<CafeteriaData> cafeteriaData;
 
  CafeteriaModel.fromJson(Map<String, dynamic> json){
    cafeteriaData = List.from(json['cafeteriaData']).map((e)=>CafeteriaData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cafeteriaData'] = cafeteriaData.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CafeteriaData {
  CafeteriaData({
    required this.bookingId,
    required this.token,
    // required this.floorNumber,
    required this.date,
    required this.startTime,
    required this.endTime,
    // required this.roomID,
    // required this.roomName,
    // required this.status,
  });
  late final int bookingId;
  late final int token;
  // late final int floorNumber;
  late final String date;
  late final String startTime;
  late final String endTime;
  // late final String roomID;
  // late final String roomName;
  // late final bool status;
 
  CafeteriaData.fromJson(Map<String, dynamic> json){
    bookingId = json['booking_id'];
    token = json['token'];
    // floorNumber = json['floor_number'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    // roomID = json['roomID'];
    // roomName = json['roomName'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['booking_id'] = bookingId;
    _data['token'] = token;
    // _data['floor_number'] = floorNumber;
    _data['date'] = date;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    // _data['roomID'] = roomID;
    // _data['roomName'] = roomName;
    // _data['status'] = status;
    return _data;
  }
}