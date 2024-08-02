// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SelectCapacity extends StatefulWidget {
  int defaultSelectedCapacity;
  Function(int capacitySelected) onCapacitySelected;
  SelectCapacity({
    Key? key,
    this.defaultSelectedCapacity = 1,
    required this.onCapacitySelected,
  }) : super(key: key);

  @override
  State<SelectCapacity> createState() => _SelectCapacityState();
}

class _SelectCapacityState extends State<SelectCapacity> {
  int selectedCapacity = -1;
  @override
  Widget build(BuildContext context) {
    if (selectedCapacity == -1) {
      selectedCapacity = widget.defaultSelectedCapacity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Select Capacity :",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (selectedCapacity > 1) {
                selectedCapacity--;
                widget.onCapacitySelected(selectedCapacity);
              }
            });
          },
          child: Text("-"),
        ),
        ElevatedButton(onPressed: () {}, child: Text("${selectedCapacity}")),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCapacity++;
              widget.onCapacitySelected(selectedCapacity);
            });
          },
          child: Text("+"),
        ),
      ],
    );
  }
}
