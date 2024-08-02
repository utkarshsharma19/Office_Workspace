// To parse this JSON data, do
//
//     final floorAvailability = floorAvailabilityFromJson(jsonString);

import 'dart:convert';

FloorAvailability floorAvailabilityFromJson(String str) => FloorAvailability.fromJson(json.decode(str));

String floorAvailabilityToJson(FloorAvailability data) => json.encode(data.toJson());

class FloorAvailability {
    List<Availability> availability;

    FloorAvailability({
        required this.availability,
    });

    factory FloorAvailability.fromJson(Map<String, dynamic> json) => FloorAvailability(
        availability: List<Availability>.from(json["Availability"].map((x) => Availability.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Availability": List<dynamic>.from(availability.map((x) => x.toJson())),
    };
}

class Availability {
    int floorNumber;
    int available;

    Availability({
        required this.floorNumber,
        required this.available,
    });

    factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        floorNumber: json["floor_number"],
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "floor_number": floorNumber,
        "available": available,
    };
}
