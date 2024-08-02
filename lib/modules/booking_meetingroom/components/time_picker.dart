import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TimePicker extends StatefulWidget {
  String startTime;
  Function(String value) _selectStartTime;
  TimePicker(this.startTime, this._selectStartTime);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      widget._selectStartTime(selectedTime.toString());
      print(widget.startTime);
      print("******");
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Inside the time picker*******");
    // print(selectedTime!.hour);
    // print(selectedTime!.minute);
    // print(selectedTime!.toString());

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Start Time :",
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
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    selectedTime != null
                        ? ' ${selectedTime?.format(context)}'
                        : 'Select start time',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.yellow[900],
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
