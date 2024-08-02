// To parse this JSON data, do
//
//     final editMeetingRoom = editMeetingRoomFromJson(jsonString);

import 'dart:convert';

EditMeetingRoom editMeetingRoomFromJson(String str) =>
    EditMeetingRoom.fromJson(json.decode(str));

String editMeetingRoomToJson(EditMeetingRoom data) =>
    json.encode(data.toJson());

class EditMeetingRoom {
  int bookingId;
  int userId;
  int floorNumber;
  String date;
  String startTime;
  String endTime;
  String roomId;
  String roomName;
  bool status;

  EditMeetingRoom({
    required this.bookingId,
    required this.userId,
    required this.floorNumber,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.roomId,
    required this.roomName,
    required this.status,
  });

  factory EditMeetingRoom.fromJson(Map<String, dynamic> json) =>
      EditMeetingRoom(
        bookingId: json["booking_id"],
        userId: json["userId"],
        floorNumber: json["floor_number"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        roomId: json["roomID"],
        roomName: json["roomName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "userId": userId,
        "floor_number": floorNumber,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "roomID": roomId,
        "roomName": roomName,
        "status": status,
      };
}
