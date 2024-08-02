// class HomeModel {
//   late List<OverallBooking> overallBooking;
//   late List<Events> events;
//   late int meetingRoom;

//   HomeModel(this.overallBooking, this.events, this.meetingRoom);

//   HomeModel.fromJson(Map<String, dynamic> json) {
//     if (json['Overall Booking'] != null) {
//       overallBooking = <OverallBooking>[];
//       json['Overall Booking'].forEach((v) {
//         overallBooking!.add(new OverallBooking.fromJson(v));
//       });
//     }
//     if (json['Events'] != null) {
//       events = <Events>[];
//       json['Events'].forEach((v) {
//         events!.add(new Events.fromJson(v));
//       });
//     }
//     meetingRoom = json['Meeting Room'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.overallBooking != null) {
//       data['Overall Booking'] =
//           this.overallBooking!.map((v) => v.toJson()).toList();
//     }
//     if (this.events != null) {
//       data['Events'] = this.events!.map((v) => v.toJson()).toList();
//     }
//     data['Meeting Room'] = this.meetingRoom;
//     return data;
//   }
// }

// class OverallBooking {
//   late int id;
//   late int userID;
//   late String amenity;
//   late int bookingID;
//   late String date;
//   late List<String> details;

//   OverallBooking(
//       this.id,
//       this.userID,
//       this.amenity,
//       this.bookingID,
//       this.date,
//       this.details);

//   OverallBooking.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userID = json['userID'];
//     amenity = json['amenity'];
//     bookingID = json['bookingID'];
//     date = json['date'];
//     details = json['details'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userID'] = this.userID;
//     data['amenity'] = this.amenity;
//     data['bookingID'] = this.bookingID;
//     data['date'] = this.date;
//     data['details'] = this.details;
//     return data;
//   }
// }

// class Events {
//   late int id;
//   late String eventName;
//   late String date;
//   late String description;

//   Events(this.id, this.eventName, this.date, this.description);

//   Events.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventName = json['event_name'];
//     date = json['date'];
//     description = json['description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['event_name'] = this.eventName;
//     data['date'] = this.date;
//     data['description'] = this.description;
//     return data;
//   }
// }
