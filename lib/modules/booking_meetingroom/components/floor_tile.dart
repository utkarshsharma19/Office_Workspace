import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FloorTile extends StatefulWidget {
  const FloorTile({super.key});

  @override
  State<FloorTile> createState() => _FloorTileState();
}

class _FloorTileState extends State<FloorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text("Floor 1"),
          Divider(
            color: Colors.black38,
          ),
          SizedBox(
            height: 30,
          ),
          Text("23")
        ],
      ),
    );
  }
}
