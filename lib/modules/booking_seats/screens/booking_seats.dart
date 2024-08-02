import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/components/date_picker_horizontal.dart';
import 'package:office_spacez/modules/booking_seats/bloc/booking_seats_bloc.dart';
import 'package:office_spacez/modules/booking_seats/components/large_button.dart';
import 'package:office_spacez/modules/booking_seats/components/seats_availability_tile.dart';
import 'package:office_spacez/modules/booking_seats/components/select_capacity.dart';
import 'package:office_spacez/utils/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingSeats extends StatefulWidget {
  const BookingSeats({super.key});

  @override
  _BookingSeatsState createState() => _BookingSeatsState();
}

class _BookingSeatsState extends State<BookingSeats> {
  DateTime selectedDate = DateTime.now();
  int selectedFloor = 0;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingSeatsBloc(
          dateSelected: selectedDate,
          floorNoSelected: selectedFloor,
          capacitySelected: 1,
          users: []),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Seats Booking"),
        ),
        body: BookingSeatsPage(),
      ),
    );
  }
}

class BookingSeatsPage extends StatelessWidget {
  BookingSeatsPage({
    super.key,
  });

  // Get the user role from shared preferences
  final role = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePickerHorizontal(
          defaultSelectedDate:
              BlocProvider.of<BookingSeatsBloc>(context).dateSelected,
          onDateSelected: (dateSelected) {
            // Update the dateSelected from date picker to bloc variable
            BlocProvider.of<BookingSeatsBloc>(context).dateSelected =
                dateSelected;
            // Trigger DateModifiedEvent - update SeatsAvailabilityTile
            BlocProvider.of<BookingSeatsBloc>(context).add(DateModifiedEvent());
            print(
                "----------Selected Date: ${BlocProvider.of<BookingSeatsBloc>(context).dateSelected}");
          },
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.0),

                SeatsAvailabilityTile(
                  defaultSelectedFloor:
                      BlocProvider.of<BookingSeatsBloc>(context)
                          .floorNoSelected,
                  onFloorSelected: (floorSelected) {
                    BlocProvider.of<BookingSeatsBloc>(context).floorNoSelected =
                        floorSelected;
                    print(
                        "----------Selected Floor: ${BlocProvider.of<BookingSeatsBloc>(context).floorNoSelected}");
                  },
                ),

                SizedBox(height: 24.0),

                // Verify manager role to display below UI
                role == "user"
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            SelectCapacity(
                              defaultSelectedCapacity: 4,
                              onCapacitySelected: (capacitySelected) {
                                BlocProvider.of<BookingSeatsBloc>(context)
                                    .capacitySelected = capacitySelected;
                                print(
                                    "----------Selected Capacity: ${BlocProvider.of<BookingSeatsBloc>(context).capacitySelected}");
                              },
                            ),
                            Container(),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),

        // Spacer(flex: 1),

        Padding(
          padding: const EdgeInsets.all(24.0),
          child: LargeButton(
            buttonText: "CONFIRM BOOKING",
            onButtonPressed: () async {
              // Trigger ConfirmBookingEvent - to make the booking
              BlocProvider.of<BookingSeatsBloc>(context)
                  .add(ConfirmBookingEvent());
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String fcmToken = prefs.getString("fcmtoken")!;
              sendNotification(
                  fcmToken, "Booking Successfull", "Booking details");
              print("Large Button Pressed");
            },
          ),
        ),

        // Spacer(flex: 2)
      ],
    );
  }

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
}
