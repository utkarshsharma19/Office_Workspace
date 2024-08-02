import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:office_spacez/modules/booking_cafeteria/api/api.dart';
import 'package:office_spacez/modules/booking_cafeteria/api/cafe_room.dart';
import 'package:office_spacez/modules/booking_cafeteria/models/booking_cafeteria_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../components/date_picker_horizontal.dart';
import '../../../components/select_time_picker.dart';
import '../../../utils/user_state.dart';
import '../../booking_meetingroom/components/availability_tile.dart';
import '../../booking_meetingroom/components/calender_widget.dart';
import '../../booking_meetingroom/components/end_time_picker.dart';
import '../../booking_meetingroom/components/time_picker.dart';

class BookCafeRoom extends StatefulWidget {
  const BookCafeRoom({Key? key});

  @override
  State<BookCafeRoom> createState() => _BookCafeRoomState();
}

class _BookCafeRoomState extends State<BookCafeRoom> {
  DateTime currentDateTime = DateTime.now();
  String selectedDate = " ";
  num _selectedIndex = 0;
  // num _selectedDate = 0;
  int _selectedCapacity = 1;
  String startTime = " ";
  String endTime = " ";
  num token = 0;
  int? statusCode = 000;

  bool showAvailCard = false;

  num cafeSeats = 0;

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

  // Widget _buildAvailCard(){
  //   return Card(
  //     child: Column(children: [
  //       Text("Capacity",
  //       style: TextStyle(
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       ),
  //       SizedBox(height: 10),
  //       ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: 5,
  //         itemBuilder: (context, index) {
  //           final capacity = 5;
  //           return ListTile(
  //             title: Text("Capacity:5")
  //           );
  //         },
  //       )
  //     ],
  //     ),
  //   );

  // }

  final MeetingRoomRepository _meetingRoomRepository = MeetingRoomRepository();

  dynamic _confirmationCallback(startTime, endTime) {
    setState(() {
      startTime = startTime;
      endTime = endTime;
    });
  }

  Future<void> _handleButtonClick() async {
    final payload = {
      "date": selectedDate,
      "start_time": startTime,
      "end_time": endTime,

      // "date": "2023-06-08 16:47:05.647151",
      // "start_time": "2023-06-06T10:09:27.379Z",
      // "end_time": "2023-06-06T12:09:27.379Z"
    };
    String jwtToken = await getUserToken();
    final headers = {'Authorization': 'Bearer ${jwtToken}'};

    try {
      final response = await DioClient.postRequest(
          'http://localhost:8080/cafeteria-booking/availability/datetime',
          headers,
          payload);
      final responseData = response.data;
      print(responseData);
      cafeSeats = int.parse(responseData);
      print("this is the response object ${responseData}");
      print("this is the cafeteria object ${cafeSeats}");

      // Handle the response data
      // List<BookingCafeModel> tempList = [];

      // for (var item in responseData) {
      //   tempList.add(BookingCafeModel.fromJson(item));
      // }

      print("*****before the json conversion");
      // final cafeSeats = BookingCafeModel.fromJson(responseData);
      print(cafeSeats);
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
                      "Cafeteria",
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
                  DatePickerHorizontal(
                    defaultSelectedDate: DateTime.now(),
                    onDateSelected: (dateSelected) {
                      // dateSelected = DateTime.now();
                      selectedDate = dateSelected.toString();
                    },
                  ),
                  // HorizontalDatePickerWidget(selectedColor: Colors.black12,startDate: DateTime.now(),endDate: DateTime.now(), selectedDate: , widgetWidth: MediaQuery.of(context).size.width * 0.009,datePickerController:, onValueSelected:)
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                  // CalendarWidget(_selectedIndex, (index) {
                  //   // _selectedDate = currentDateTime.day + index;
                  //   setState(() {
                  //     _selectedDate = currentDateTime.day + index;
                  //     selectedDate = DateTime(DateTime.now().year,
                  //             DateTime.now().month, _selectedDate.toInt())
                  //         .toString()
                  //         .split(" ")[0];
                  //   });
                  // }),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.05),
                      child: Container(
                          child: Column(
                        children: [
                          SelectTimePicker(
                              defaultSelectedTime: "",
                              timeType: TimeType.START_TIME,
                              onTimeSelected: (timeSelected) =>
                                  {startTime = timeSelected}
                              // timeSelected = startTime,
                              ),
                          SelectTimePicker(
                              defaultSelectedTime: "",
                              timeType: TimeType.END_TIME,
                              onTimeSelected: (timeSelected) => {
                                    endTime = timeSelected,
                                  }),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _handleButtonClick();
                                    setState(() {
                                      cafeSeats = cafeSeats;
                                    });
                                  },
                                  child: Text("Check availability")),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Card(
                              child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Center(child: Text('${cafeSeats}')),
                          )),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          InkWell(
                            onTap: () async {
                              // final confirmationBookingResponse =
                              // final userid = await getUserId();
                              print(
                                  "*************this is the current user id*************");
                              // print(userid);
                              // final user = us

                              final status = await _meetingRoomRepository
                                  .confirmPostCallback(
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
                                      'string');
                              print("This is the status----->${status}");
                              statusCode = status;
                              print(
                                  "This is the statusCode before setState----->${statusCode}");

                              if (status == 201) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String fcmToken = prefs.getString("fcmtoken")!;
                                sendNotification(fcmToken,
                                    "Booking Successfull", "Booking details");
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
                                            style:
                                                TextStyle(color: Colors.black),
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
                                sendNotification(fcmToken, "Booking Failed",
                                    "Booking details");
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
                      )))
                ]))));
  }
}
