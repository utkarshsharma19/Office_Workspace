import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarItem extends StatefulWidget {
  final DateTime date;

  CalendarItem(this.date);

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  bool isTapped = false;

  void toggleTap() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
        ),
        height: 100,
        width: 80,
        padding: EdgeInsets.all(8),
        child: InkWell(
          child: Column(
            children: [
              Text(
                DateFormat.MMM().format(widget.date),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                DateFormat.d().format(widget.date),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  height: 5, color: isTapped ? Colors.amber : Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
