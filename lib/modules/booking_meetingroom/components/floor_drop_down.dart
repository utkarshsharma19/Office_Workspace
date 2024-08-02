import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FloorDropDown extends StatefulWidget {
  const FloorDropDown({super.key});

  @override
  State<FloorDropDown> createState() => _FloorDropDownState();
}

class _FloorDropDownState extends State<FloorDropDown> {
  List<String> dropdownItems = ['Floor 1', 'Floor 2', 'Floor 3', 'Floor 4'];

  String? selectedItem;
  // int _expandedIndex =

  @override
  Widget build(BuildContext context) {
    return Container(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.start,
      child:
          // Text(
          //   "Floors",
          //   style: TextStyle(
          //       fontFamily: 'Montserrat',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 18),
          // ),
          // SizedBox(
          //   width: 100,
          // ),
          DropdownButtonFormField<String>(
        value: selectedItem,
        hint: Text("Select the Floor"),
        decoration: InputDecoration(border: OutlineInputBorder()),
        // elevation: 10,
        isExpanded: true,
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedItem = newValue;
          });
        },
      ),
    );
  }
}
