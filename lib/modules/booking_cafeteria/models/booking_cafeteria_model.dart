// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookingCafeModel welcomeFromJson(String str) =>
    BookingCafeModel.fromJson(json.decode(str));

String welcomeToJson(BookingCafeModel data) => json.encode(data.toJson());

class BookingCafeModel {
  String? date;
  String? startTime;
  String? endTime;
  int? capacity;
  // String? room_name;
  // num? floor_number;
  // String roomId;
  int? id;
  int? booking_id;

  BookingCafeModel(
      {required this.date,
      required this.startTime,
      required this.endTime,
      required this.capacity,
      // required this.room_name,
      // required this.floor_number,
      // required this.roomId,
      required this.id,
      required this.booking_id});

  factory BookingCafeModel.fromJson(Map<String, dynamic> json) =>
      BookingCafeModel(
          date: json["date"],
          startTime: json["start_time"],
          endTime: json["end_time"],
          capacity: json["capacity"],
          // room_name: json["room_name"],
          // floor_number: json["floor_number"],
          // roomId: json["roomId"],
          booking_id: json['booking_id'],
          id: json['id']);

  Map<String, dynamic> toJson() => {
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "capacity": capacity,
        // "floor_number": floor_number,
        // "roomId": roomId,
        "booking_id": booking_id,
        "id": id,

      };
}
