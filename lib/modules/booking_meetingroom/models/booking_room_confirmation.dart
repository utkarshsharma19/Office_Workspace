// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookingConfirmationModel welcomeFromJson(String str) =>
    BookingConfirmationModel.fromJson(json.decode(str));

String welcomeToJson(BookingConfirmationModel data) =>
    json.encode(data.toJson());

class BookingConfirmationModel {
  String? date;
  String? startTime;
  String? endTime;
  String? roomId;
  String? roomName;
  bool? status;
  int? userId;
  int? floor;

  BookingConfirmationModel({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.roomId,
    required this.roomName,
    required this.status,
    required this.userId,
    required this.floor,
  });

  factory BookingConfirmationModel.fromJson(Map<String, dynamic> json) =>
      BookingConfirmationModel(
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        roomId: json["room_id"],
        roomName: json["room_name"],
        status: json["status"],
        userId: json["userID"],
        floor: json["floor"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "room_id": roomId,
        "room_name": roomName,
        "status": status,
        "userID": userId,
        "floor": floor,
      };
}
