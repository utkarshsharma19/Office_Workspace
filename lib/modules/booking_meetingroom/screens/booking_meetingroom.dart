import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:office_spacez/modules/booking_meetingroom/api/api.dart';
import 'package:office_spacez/modules/booking_meetingroom/api/meetingroom_repo.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/availability_tile.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/calender_widget.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/end_time_picker.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/floor_drop_down.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/room_drop_down.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/time_picker.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/user_chip.dart';
import 'package:flutter/material.dart';
import 'package:office_spacez/modules/booking_meetingroom/models/booking_room_model.dart';
import 'package:office_spacez/utils/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingMeetingRoom extends StatefulWidget {
  const BookingMeetingRoom({Key? key});

  @override
  State<BookingMeetingRoom> createState() => _BookingMeetingRoomState();
}

class _BookingMeetingRoomState extends State<BookingMeetingRoom> {
  //the api payload for the get avalabilities and create a meeting room availability
  DateTime currentDateTime = DateTime.now();
  String selectedDate = " ";
  num _selectedIndex = 0;
  num _selectedDate = 0;
  int _selectedCapacity = 1;
  String startTime = " ";
  String endTime = " ";
  List<BookingRoomModel> rooms = [];
  String room_id = " ";
  String room_name = " ";
  num userID = 0;
  num floor = 0;
  int? statusCode = 000;
  // String userId = await getUserId();
  // late Future<int?> confirmationBookingResponse;

  final MeetingRoomRepository _meetingrepository = MeetingRoomRepository();

  Future<void> sendNotification(
      String fcmToken, String title, String notificationBody) async {
    final serverKey =
        'AAAAq2AOff4:APA91bH0CdGOteDp9sGlwpH0UXIFD-BsSwcBQOumYfqEA6-T7lYpupXEZqOWjZprSIoO6tdY3QHYlvFZiqPhVu9XY2ugKukF-mGMDbNNyHiHyVgSX3JT1NanBbwcHq8_lK4EM78W6-jf';
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final body = jsonEncode({
      'notification': {
        'title': title,
        'body': notificationBody,
      },
      'to': fcmToken,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.body}');
    }
  }

  void _confirmationCallback(
      roomIdValue, roomNameValue, userIdValue, floorValue) {
    setState(() {
      room_id = roomIdValue;
      room_name = roomNameValue;
      userID = userIdValue;
      floor = floorValue;
    });
  }

  Future<void> _handleButtonClick() async {
    final payload = {
      "date": selectedDate,
      "start_time": startTime,
      "end_time": endTime,
      "capacity": _selectedCapacity
    };

    try {
      final response = await DioClient.postRequest(
          'http://localhost:8080/meetingroom-booking/getAvailableRoomNames',
          payload);
      final responseData = response.data;

      // Handle the response data
      List<BookingRoomModel> tempList = [];
      for (var item in responseData) {
        tempList.add(BookingRoomModel.fromJson(item));
      }

      setState(() {
        rooms = tempList;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            // backgroundColor: Colors.black,
            leading: InkWell(
              // Navigate back to home ////////////////////////////// back to Home
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_new),
            ),
            title: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 55, 10),
                child: Text(
                  "Meeting Rooms",
                  style: TextStyle(
                    // color: Colors.yellow[900],
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    letterSpacing: 1.5,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.009),
              CalendarWidget(_selectedIndex, (index) {
                // _selectedDate = currentDateTime.day + index;
                setState(() {
                  _selectedDate = currentDateTime.day + index;
                  selectedDate = DateTime(DateTime.now().year,
                          DateTime.now().month, _selectedDate.toInt())
                      .toString()
                      .split(" ")[0];
                });
              }),
              // Text(
              //     // "${DateTime(DateTime.now().year, DateTime.now().month, _selectedDate.toInt()).toString().split(" ")[0]}"
              //     // "${selectedDate.toString() + "T" + startTime.split("(")[1].split(")")[0] + ":00Z"}",
              //     "${room_id}"),
              // Text("${room_name}"),
              // Text("${statusCode}"),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: Container(
                  child: Column(
                    children: [
                      TimePicker(startTime, (value) {
                        setState(() {
                          startTime = value;
                        });
                        startTime = selectedDate.toString() +
                            "T" +
                            startTime.split("(")[1].split(")")[0] +
                            ":00Z";
                      }),
                      EndTimePicker(endTime, (value) {
                        setState(() {
                          endTime = value;
                        });
                        endTime = selectedDate.toString() +
                            "T" +
                            endTime.split("(")[1].split(")")[0] +
                            ":00Z";
                      }),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      // Text(
                      //   "Availabilities on floors",
                      //   style: TextStyle(
                      //     fontFamily: 'Montserrat',
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: MediaQuery.of(context).size.width * 0.04,
                      //   ),
                      // ),
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.02),
                      // AvailabilityTile(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Select Capacity :",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              )),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedCapacity++;
                                });
                                print(endTime);
                                print(startTime);
                              },
                              child: Text("+")),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text("${_selectedCapacity}")),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedCapacity--;
                                });
                              },
                              child: Text("-")),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _handleButtonClick();
                              },
                              child: Text("Check availability")),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      AvailabilityTile(
                        rooms: rooms,
                        callback: _confirmationCallback,
                      ),
                      // FloorDropDown(),
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.02),
                      // RoomDropDown(),
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.02),
                      // // Container(
                      // //     // keyboardType: TextInputType.emailAddress,
                      // //     child: ,
                      // //     ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      EmailChips(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      InkWell(
                        onTap: () async {
                          // final confirmationBookingResponse =
                          final userid = await getUserId();
                          print(
                              "*************this is the current user id*************");
                          print(userid);
                          // final user = us

                          final status =
                              await _meetingrepository.confirmationPostCallback(
                                  // "2023-05-31",
                                  // "2023-05-31T15:00:00Z",
                                  // "2023-05-31T17:00:00Z",
                                  // "6",
                                  // "Vyas",
                                  // 1,
                                  // 2
                                  selectedDate,
                                  startTime,
                                  endTime,
                                  room_id,
                                  room_name,
                                  int.parse(userid),
                                  floor);
                          print("This is the status----->${status}");
                          statusCode = status;
                          print(
                              "This is the statusCode before setState----->${statusCode}");

                          if (status == 201) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String fcmToken = prefs.getString("fcmtoken")!;
                            sendNotification(fcmToken, "Booking Successfull",
                                "Booking details");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Success'),
                                  titleTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                  backgroundColor: Colors.greenAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  content: Text('Booking was successful!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, "/home");
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String fcmToken = prefs.getString("fcmtoken")!;
                            sendNotification(
                                fcmToken, "Booking Failed", "Booking details");

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  titleTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  content: Text(
                                      'POST request failed with status code: $status'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          // setState(() {
                          //   statusCode = status;
                          // });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              'CONFIRM BOOKING',
                              style: TextStyle(
                                color: Colors.yellow[900],
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
