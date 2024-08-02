

// import 'package:flutter/widgets.dart';

// class MeetingModel {
// //  final int id;
// //  final String amenity;
//  final int userID;
//  final int bookingID;
//  final int floor;
//  final String startTime;
//  final String endTime;
//  final String meetingRoomId;
//  final String meetingRoomName;
//  final String date;
//  final bool status;

//  MeetingModel({
//     // required  this.id,
//     // required this.amenity,
//     required this.userID,
//     required this.bookingID,
//     required this.floor,
//     required this.startTime,
//     required this.endTime,
//     required this.meetingRoomId,
//     required this.meetingRoomName,
//     required this.date, 
//     required this.status,

//   });

//   factory MeetingModel.fromJson(Map<String, dynamic> json) {
//     return MeetingModel(
//       // id: json['id'] as int,
//       // amenity: json['amenity'] as String,
//       userID: json['userId'] as int,
//       bookingID: json['booking_id'] as int,
//       floor: json['floor_number'] as int,
//       startTime: json['startTime'] as String,
//       endTime: json['endTime'] as String, 
//       meetingRoomId: json['roomId'] as String,
//       meetingRoomName: json['roomName'] as String,
//       date: json['date'] as String,
//       status: json['status'] 
//     );
//   }
// /*{ "id": 4, "userID": 457689, "amenity": "Meeting Room", "bookingID": 5,
//   "start_time": "2023-05-22T08:58:06.403Z", "end_time": "2023-05-22T09:58:06.403Z",
//   "floor": 1, "meeting_room_id": "G1", "meeting_room_name": "Amex", "date": "2020–04–01 21:02:09.367"}*/

//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     // 'id': id,
//   //     'userID': userID,
//   //     'bookingID': bookingID,
//   //     'floor': floor,
//   //     // 'amenity': amenity,
//   //     'start_time': startTime,
//   //     'end_time': endTime,
//   //     'meeting_room_id': meetingRoomId,
//   //     'meeting_room_name': meetingRoomName,
//   //     'date': date,
//   //   };
//   // }
// }

class MeetingModel {
  MeetingModel({
    required this.seatingData,
  });
  late final List<SeatingData> seatingData;
 
  MeetingModel.fromJson(Map<String, dynamic> json){
    seatingData = List.from(json['seatingData']).map((e)=>SeatingData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['seatingData'] = seatingData.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SeatingData {
  SeatingData({
    required this.bookingId,
    required this.token,
    required this.floorNumber,
    required this.date,
    required this.startTime,
    required this.endTime,
    // required this.roomID,
    required this.users,
    required this.roomName,
    required this.status,
  });
  late final int bookingId;
  late final String token;
  late final int floorNumber;
  late final String date;
  late final String startTime;
  late final String endTime;
  // late final String roomID;
  late final String roomName;
  late final bool status;
  late final List<String>? users;
 
  factory SeatingData.fromJson(Map<String, dynamic> json)=>
  SeatingData(
    bookingId :json['booking_id'],
    token : json['token'],
    floorNumber : json['floorId'],
    date : json['date'],
    startTime :json['startTime'],
    endTime : json['endTime'],
    // roomID = json['roomID'];
    roomName : json['roomName'],
    status: json['status'],
    users: json["users"] != null
              ? List<String>.from(json["users"].map((x) => x))
              : null,
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['booking_id'] = bookingId;
    _data['token'] = token;
    _data['floorId'] = floorNumber;
    _data['date'] = date;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    // _data['roomID'] = roomID;
    _data['roomName'] = roomName;
    _data['status'] = status;
    return _data;
  }
}