import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EndTimePicker extends StatefulWidget {
  String endTime;
  Function(String value) _selectEndTime;
  EndTimePicker(this.endTime, this._selectEndTime, {super.key});

  @override
  State<EndTimePicker> createState() => _EndTimePickerState();
}

class _EndTimePickerState extends State<EndTimePicker> {
  TimeOfDay? endTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != endTime) {
      setState(() {
        endTime = pickedTime;
      });
      widget._selectEndTime(endTime.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "End Time :",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   endTime != null ? ' ${endTime?.format(context)}' : 'End Time',
              //   style: TextStyle(fontSize: 20),
              // ),
              // SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.56,
                child: ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    endTime != null
                        ? ' ${endTime?.format(context)}'
                        : 'Select end time',
                    style: TextStyle(
                      color: Colors.yellow[900],
                      fontSize: 15,
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
