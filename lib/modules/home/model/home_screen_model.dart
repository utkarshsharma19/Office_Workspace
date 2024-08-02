// To parse this JSON data, do
//
//     final homeScreenModel = homeScreenModelFromJson(jsonString);

import 'dart:convert';

HomeScreenModel homeScreenModelFromJson(String str) => HomeScreenModel.fromJson(json.decode(str));

String homeScreenModelToJson(HomeScreenModel data) => json.encode(data.toJson());

class HomeScreenModel {
    List<OverallBooking> overallBooking;
    List<Event> events;
    int meetingRoom;
    int seats;
    int cafeteria;

    HomeScreenModel({
        required this.overallBooking,
        required this.events,
        required this.meetingRoom,
        required this.seats,
        required this.cafeteria,
    });

    factory HomeScreenModel.fromJson(Map<String, dynamic> json) => HomeScreenModel(
        overallBooking: List<OverallBooking>.from(json["Overall_Booking"].map((x) => OverallBooking.fromJson(x))),
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
        meetingRoom: json["Meeting Room"],
        seats: json["Seats"],
        cafeteria: json["Cafeteria"],
    );

    Map<String, dynamic> toJson() => {
        "Overall_Booking": List<dynamic>.from(overallBooking.map((x) => x.toJson())),
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
        "Meeting Room": meetingRoom,
        "Seats": seats,
        "Cafeteria": cafeteria,
    };
}

class Event {
    int id;
    String eventName;
    DateTime date;
    String description;

    Event({
        required this.id,
        required this.eventName,
        required this.date,
        required this.description,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        eventName: json["event_name"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "date": date.toIso8601String(),
        "description": description,
    };
}

class OverallBooking {
    int id;
    String token;
    String amenity;
    int bookingId;
    DateTime date;
    List<String> details;

    OverallBooking({
        required this.id,
        required this.token,
        required this.amenity,
        required this.bookingId,
        required this.date,
        required this.details,
    });

    factory OverallBooking.fromJson(Map<String, dynamic> json) => OverallBooking(
        id: json["id"],
        token: json["token"],
        amenity: json["amenity"],
        bookingId: json["bookingID"],
        date: DateTime.parse(json["date"]),
        details: List<String>.from(json["details"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "amenity": amenity,
        "bookingID": bookingId,
        "date": date.toIso8601String(),
        "details": List<dynamic>.from(details.map((x) => x)),
    };
}
