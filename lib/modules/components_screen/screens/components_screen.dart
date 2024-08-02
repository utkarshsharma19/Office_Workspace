import 'package:flutter/material.dart';
import 'package:office_spacez/components/date_picker_horizontal.dart';
import 'package:office_spacez/components/select_time_picker.dart';
// import 'package:office_spacez/modules/booking_meetingroom/components/time_picker.dart';

class ComponentsScreen extends StatelessWidget {
  const ComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    // String startTime = selectedDate.toIso8601String();
    String startTime = "";
    return Scaffold(
      body: Center(
        child: SelectTimePicker(
          defaultSelectedTime: startTime,
          timeType: TimeType.END_TIME,
          onTimeSelected: (timeSelected) {
            startTime = timeSelected;
            print("Selected value in Component Screen: $startTime");
          },
        ),
      ),
    );
  }
}
