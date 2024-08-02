import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/modules/booking_seats/bloc/booking_seats_bloc.dart';

class SeatsAvailabilityTile extends StatefulWidget {
  int defaultSelectedFloor;
  Function(int floorSelected) onFloorSelected;
  SeatsAvailabilityTile({
    required this.defaultSelectedFloor,
    required this.onFloorSelected,
  });
  @override
  State<SeatsAvailabilityTile> createState() => _SeatsAvailabilityTileState();
}

class _SeatsAvailabilityTileState extends State<SeatsAvailabilityTile> {
  int selectedIndex = -1;
  int floorNo = 1, availabilityCount = 23;

  void _selectItem(int index) {
    selectedIndex = index;
    widget.onFloorSelected(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == -1) {
      selectedIndex = widget.defaultSelectedFloor;
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.3,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black26),
      // ),

      child: BlocConsumer<BookingSeatsBloc, BookingSeatsState>(
        listener: (context, state) {
          // do stuff here based on BookingSeatsBloc's state
        },
        builder: (context, state) {
          if (state is BookingSeatsInitial ||
              state is SeatsAvailabilityTileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SeatsAvailabilityTileSuccess) {
            return ListView.separated(
              itemCount: state.floorAvailabilityModel.availability.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 8,
                ); // Adjust the width as per your preference
              },
              itemBuilder: (context, index) {
                return Material(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectItem(state.floorAvailabilityModel.availability[index].floorNumber);
                      });
                    },
                    child: Container(
                      
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 70,
                      width: 110,
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "Floor",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${state.floorAvailabilityModel.availability[index].floorNumber}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${state.floorAvailabilityModel.availability[index].available}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              height: 3,
                              color: selectedIndex == state.floorAvailabilityModel.availability[index].floorNumber
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                //  Divider(width:MediaQuery.of(context).size.width * 0.9)
              },
            );
          } else if (state is SeatsAvailabilityTileError) {
            return const Center(child: Text("Error"));
          } else {
            return const Center(child: Center(child: Text("Null")));
          }
        },
      ),
    );
  }
}
