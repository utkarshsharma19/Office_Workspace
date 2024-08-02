import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

// Usage
// Pass the default date value in constructor
// Use call back function's parameter value to update your local variable in your screen
// -----------------------For Make Bookings Screen-----------------------
/*
    DatePickerHorizontal(
      defaultSelectedDate: DateTime.now(),
      onDateSelected: (dateSelected) {
        selectedDate = dateSelected; // Updating your local variable
      },
    ),
*/

// -----------------------For Edit Bookings Screen-----------------------
/*
    DatePickerHorizontal(
      defaultSelectedDate: <DateTime object of date received from booking api>,
      onDateSelected: (dateSelected) {
        selectedDate = dateSelected;
        print("Selected value in Component Screen: $selectedDate");
      },
    ),
*/

class DatePickerHorizontal extends StatefulWidget {
  final DateTime defaultSelectedDate;
  Function(DateTime dateSelected) onDateSelected;

  DatePickerHorizontal({
    Key? key,
    required this.defaultSelectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerHorizontalState createState() => _DatePickerHorizontalState();
}

class _DatePickerHorizontalState extends State<DatePickerHorizontal> {
  DatePickerController _datePickerController = DatePickerController();

  @override
  Widget build(BuildContext context) {
    // Set the default to defaultSelectedDate passed from constructor
    DateTime defaultDate = widget.defaultSelectedDate;

    DateTime startDate = defaultDate;
    DateTime endDate = defaultDate.add(const Duration(days: 7));
    print('startDate = $startDate ; endDate = $endDate');

    // HorizontalDatePickerWidget component from the package
    return HorizontalDatePickerWidget(
      selectedColor: Theme.of(context).primaryColor,
      startDate: startDate,
      endDate: endDate,
      selectedDate: defaultDate,
      widgetWidth: MediaQuery.of(context).size.width,
      datePickerController: _datePickerController,
      
      // Performing Call Back
      onValueSelected: widget.onDateSelected,
    );
  }
}
