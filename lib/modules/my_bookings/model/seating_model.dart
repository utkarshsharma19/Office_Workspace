class SeatingModel {
  SeatingModel({
    required this.seatsData,
  });
  late final List<SeatingClass> seatsData;
 
  SeatingModel.fromJson(Map<String, dynamic> json){
    seatsData = List.from(json['seatsData']).map((e)=>SeatingClass.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['seatsData'] = seatsData.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class SeatingClass {
  SeatingClass({
    required this.bookingId,
    required this.userId,
    required this.floorNumber,
    required this.status,
    required this.date,
    
   
  });
  
  late final int bookingId;
  late final int userId;
  late final int floorNumber;
  late final bool status;
  late final String date;
  
  // "booking_id": 1,
  //   "userId": 1,
  //   "floor_number": 1,
  //   "status": true,
  //   "date": "2023-05-31T10:47:59.065Z"

   SeatingClass.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    userId = json['userId'];
    floorNumber = json['floor_number'];
    status = json['status'];
    date = json['date'];
    
    
  }
/*{ "id": 4, "userID": 457689, "amenity": "Seating Room", "bookingID": 5,
  "start_time": "2023-05-22T08:58:06.403Z", "end_time": "2023-05-22T09:58:06.403Z",
  "floor": 1, "meeting_room_id": "G1", "meeting_room_name": "Amex", "date": "2020–04–01 21:02:09.367"}*/

  Map<String, dynamic> toJson() {
     final _data = <String, dynamic>{};
    _data['booking_id'] = bookingId;
    _data['userId'] = userId;
    _data['floor_number'] = floorNumber;
    _data['status'] = status;
    _data['date'] = date;
    
    return _data;
  }
}



// class MeetingModel {
//   MeetingModel({
//     required this.seatingData,
//   });
//   late final List<SeatingData> seatingData;
 
//   MeetingModel.fromJson(Map<String, dynamic> json){
//     seatingData = List.from(json['seatingData']).map((e)=>SeatingData.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['seatingData'] = seatingData.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

// class SeatingData {
//   SeatingData({
//     required this.bookingId,
//     required this.userId,
//     required this.floorNumber,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//     required this.roomID,
//     required this.roomName,
//     required this.status,
//   });
//   late final int bookingId;
//   late final int userId;
//   late final int floorNumber;
//   late final String date;
//   late final String startTime;
//   late final String endTime;
//   late final String roomID;
//   late final String roomName;
//   late final bool status;
 
//   SeatingData.fromJson(Map<String, dynamic> json){
//     bookingId = json['booking_id'];
//     userId = json['userId'];
//     floorNumber = json['floor_number'];
//     date = json['date'];
//     startTime = json['startTime'];
//     endTime = json['endTime'];
//     roomID = json['roomID'];
//     roomName = json['roomName'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['booking_id'] = bookingId;
//     _data['userId'] = userId;
//     _data['floor_number'] = floorNumber;
//     _data['date'] = date;
//     _data['startTime'] = startTime;
//     _data['endTime'] = endTime;
//     _data['roomID'] = roomID;
//     _data['roomName'] = roomName;
//     _data['status'] = status;
//     return _data;
//   }
// }