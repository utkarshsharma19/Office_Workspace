// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:office_spacez/modules/booking_meetingroom/components/floor_tile.dart';
import 'package:office_spacez/modules/booking_meetingroom/models/booking_room_model.dart';

class AvailabilityTile extends StatefulWidget {
  final List<BookingRoomModel> rooms;
  Function(String roomIdValue, String roomNameValue, num userIdValue,
      num floorValue) callback;

  AvailabilityTile({Key? key, required this.rooms, required this.callback})
      : super(key: key);

  @override
  State<AvailabilityTile> createState() => _AvailabilityTileState();
}

class _AvailabilityTileState extends State<AvailabilityTile> {
  num _selectedIndex = 0;

  void _selectItem(num index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.3,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black26),
        // ),

        child: ListView.separated(
            itemCount: widget.rooms.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                  width: 7); // Adjust the width as per your preference
            },
            itemBuilder: (_, index) {
              return Material(
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectItem(index);
                    });
                    widget.callback(
                        widget.rooms[index.toInt()].roomId,
                        widget.rooms[index.toInt()].room_name!,
                        1,
                        widget.rooms[index.toInt()].floor_number!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10)),
                    height: 70,
                    width: 110,
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            "${widget.rooms[index].room_name}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Floor: ${widget.rooms[index].floor_number}",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Cap: ${widget.rooms[index].capacity}",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
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
              //  Divider(width:MediaQuery.of(context).size.width * 0.9)
            }));
  }
}
