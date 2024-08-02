// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookingRoomModel welcomeFromJson(String str) =>
    BookingRoomModel.fromJson(json.decode(str));

String welcomeToJson(BookingRoomModel data) => json.encode(data.toJson());

class BookingRoomModel {
  String? date;
  String? startTime;
  String? endTime;
  int? capacity;
  String? room_name;
  num? floor_number;
  String roomId;

  BookingRoomModel(
      {required this.date,
      required this.startTime,
      required this.endTime,
      required this.capacity,
      required this.room_name,
      required this.floor_number,
      required this.roomId});

  factory BookingRoomModel.fromJson(Map<String, dynamic> json) =>
      BookingRoomModel(
          date: json["date"],
          startTime: json["start_time"],
          endTime: json["end_time"],
          capacity: json["capacity"],
          room_name: json["room_name"],
          floor_number: json["floor_number"],
          roomId: json["roomId"]);

  Map<String, dynamic> toJson() => {
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "capacity": capacity,
        "floor_number": floor_number,
        "roomId": roomId,
      };
}
