import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class RoomDropDown extends StatefulWidget {
  const RoomDropDown({super.key});

  @override
  State<RoomDropDown> createState() => _RoomDropDownState();
}

class _RoomDropDownState extends State<RoomDropDown> {
  List<String> dropdownItems = [
    'Krishna',
    'Indus',
    'Tungabhadra',
    'Ganga',
    'Narmada',
    'Mahanadi',
    'Chambal'
  ];

  String? selectedItem;

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
        hint: Text("Select the Meeting Room"),
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
