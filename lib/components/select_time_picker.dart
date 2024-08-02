import 'package:flutter/material.dart';

enum TimeType { START_TIME, END_TIME }

// Usage - Pass DateTime.isoString() get DateTime.isoString() from call back 

// Use this component for start time or end time picker based on TimeType enum

// It accepts defaultSelectedTime as String if not pass ""

// Use call back function's parameter value to update your local variable in your screen
 
class SelectTimePicker extends StatefulWidget {
  String defaultSelectedTime;
  TimeType timeType;
  Function(String timeSelected) onTimeSelected;
  SelectTimePicker({
    required this.defaultSelectedTime,
    required this.timeType,
    required this.onTimeSelected,
  });

  @override
  State<SelectTimePicker> createState() => _SelectTimePickerState();
}

class _SelectTimePickerState extends State<SelectTimePicker> {
  TimeOfDay? selectedTime;
  late TimeOfDay? pickedTime;
  Future<void> _selectTime(BuildContext context) async {
    // -------------------If value is passed to defaultSelectedTime-------------------
    if (widget.defaultSelectedTime != "") {
      pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(DateTime.parse(widget.defaultSelectedTime)),
        // initialTime: TimeOfDay.fromDateTime(DateTime.parse(widget.startTime)) ?? TimeOfDay.now(),
        // initialTime: selectedTime ?? TimeOfDay.now(),
      );
    } else {
      pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
      );
    }

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });

      // Logic for TimeofDay object to DateTime object then returning IsoDateString
      if (selectedTime != null) {
        DateTime now = DateTime.now();
        DateTime selectedTimeAsDateTime = DateTime(now.year, now.month, now.day,
            selectedTime!.hour, selectedTime!.minute);
        
        // --------------------- Call Back to the function ---------------------
        widget.onTimeSelected(selectedTimeAsDateTime.toIso8601String());

        // print(selectedTimeAsDateTime.toIso8601String());
        // print(TimeOfDay.fromDateTime(selectedTimeAsDateTime));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Inside the time picker*******");
    // print(selectedTime!.hour);
    // print(selectedTime!.minute);
    // print(selectedTime!.toString());
    // selectedTime = TimeOfDay.fromDateTime(DateTime.parse(widget.startTime));

    // -------------------If value is passed to defaultSelectedTime-------------------
    if (widget.defaultSelectedTime != "" && selectedTime == null) {
      selectedTime =
          TimeOfDay.fromDateTime(DateTime.parse(widget.defaultSelectedTime));
    }

    // Based on enum TimeType selected set titleText and defaultText for the component 
    String defaultText = "", titleText = "";
    if (widget.timeType == TimeType.START_TIME) {
      titleText = "Start Time : ";
      defaultText = "Select Start Time";
    } else if (widget.timeType == TimeType.END_TIME) {
      titleText = "End Time : ";
      defaultText = "Select End Time";

    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
          // SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.56,
                child: ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)),
                  child: Text(
                    selectedTime != null
                        ? ' ${selectedTime?.format(context)}'
                        : defaultText,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
