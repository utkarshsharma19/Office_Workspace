import 'package:flutter/material.dart';
import 'calender_item.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  num _selectedIndex;
  Function(num value) returnIndex;

  CalendarWidget(this._selectedIndex, this.returnIndex, {super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late ScrollController scrollController;
  DateTime currentDateTime = DateTime.now();
  late DateTime date;
  num _selectedIndex = 0;
  bool isTapped = false;

  void _selectItem(num index) {
    // _selectedIndex = index;
    // widget.returnIndex(widget._selectedIndex);
    setState(() {
      _selectedIndex = index;

      widget._selectedIndex = _selectedIndex;
      // print(widget._selectedIndex);
      //   print("******inside child***");
    });
    widget.returnIndex(widget._selectedIndex);
  }

  void toggleTap() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  void initState() {
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(currentDateTime);
    // print(currentDateTime.day + 2);
    // print("************");
    // print(currentDateTime.d)
    // print(currentDateTime);
    return Container(
      height: 79, // Adjust the height as needed
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7, // Number of calendar items to display
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 5);
        },
        itemBuilder: (context, index) {
          date = DateTime.now().add(Duration(days: index));
          print("******inside the picker");
          // print(DateTime.to);
          print("wrapper date");
          // return CalendarItem(date);
          return InkWell(
            // onTap: toggleTap,
            onTap: () {
              _selectItem(index);
            },

            child: Material(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(7)),
                height: 100,
                width: 80,
                padding: EdgeInsets.all(8),
                child: InkWell(
                  child: Column(
                    children: [
                      Text(
                        DateFormat.MMM().format(date),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        DateFormat.d().format(date),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          height: 3,
                          color: _selectedIndex == index
                              ? Colors.yellow[900]
                              : Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
