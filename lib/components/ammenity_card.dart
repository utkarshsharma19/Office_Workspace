import 'package:flutter/material.dart';
import 'package:office_spacez/modules/edit_booking_meetingroom/screens/edit_view_meetingroom.dart';

enum AmmenityType { MEETING_ROOM, SEATS, CAFETERIA }

// Usage

// Pass the AmmenityType
// Along with the title 
class AmmenityCard extends StatelessWidget {
  AmmenityCard({
    Key? key,
    required this.ammenityType,
    required this.titleText,
    required this.scheduleText,
    required this.locationText,
    required this.bookingId
  }) : super(key: key);

  // enum to get Ammenity Based on which render different cards
  final AmmenityType ammenityType;

  // Update each of these variables used inside AmmenityCard based on AmmenityType
  final String titleText, scheduleText, locationText;
  IconData ammenityIcon = Icons.meeting_room;

  // Update booking id to pass it to the edit screens
  final int bookingId;

  // String editRoute = ""; // use it in case named routes are used

  // Update the subtitleText1 and subtitleText2 based on the type of ammenity
  void updateCardDetailsBasedOnAmmenity(AmmenityType ammenityType) {
    if (ammenityType == AmmenityType.MEETING_ROOM) {
      ammenityIcon = Icons.meeting_room;
    } else if (ammenityType == AmmenityType.SEATS) {
      ammenityIcon = Icons.workspaces;
    } else if (ammenityType == AmmenityType.CAFETERIA) {
      ammenityIcon = Icons.local_cafe;
    }
  }

  @override
  Widget build(BuildContext context) {
    updateCardDetailsBasedOnAmmenity(ammenityType);
    return InkWell(
      // Navigate to the Edit Booking ////////////////////////////// redirect to edit booking
      // with booking id as props
      // onTap: () => Navigator.of(context).pushNamed('/edit_booking_meetingroom'),
      onTap: () {
        if (ammenityType == AmmenityType.MEETING_ROOM) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  EditViewMeetingRoom(booking_id: bookingId),
            ),
          );
        } else if (ammenityType == AmmenityType.SEATS) {}
      },
      child: SizedBox(
        height: 120.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
          child: Center(
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    ammenityIcon,
                    size: 40.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              title: Text(
                titleText,
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: SizedBox(
                height: 50.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(scheduleText, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    // SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Icon(Icons.location_pin, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(locationText, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


        
        // return InkWell(
        //   // Navigate to the Edit Booking ////////////////////////////// redirect to edit booking
        //   // onTap: () => Navigator.of(context).pushNamed('/edit_booking_meetingroom'),
        //   onTap: () {
        //     if (item.amenity == "Meeting Room") {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (BuildContext context) =>
        //               EditViewMeetingRoom(booking_id: item.bookingID),
        //         ),
        //       );
        //     } else if (item.amenity == "Seatings") {}
        //   },
        //   child: Card(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     elevation: 4.0,
        //     child: ListTile(
        //       contentPadding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
        //       leading: ClipRRect(
        //         borderRadius: BorderRadius.circular(20.0),
        //         child: Container(
        //           padding: EdgeInsets.all(8.0),
        //           color: Theme.of(context).colorScheme.secondary,
        //           child: Icon(
        //             ammenityIcon,
        //             size: 40.0,
        //             color: Theme.of(context).colorScheme.primary,
        //           ),
        //         ),
        //       ),
        //       title: Text(item.amenity, style: TextStyle(fontWeight: FontWeight.w600),),
        //       subtitle: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SizedBox(height: 8.0),
        //           Row(
        //             children: [
        //               Icon(Icons.access_time_filled, size: 16.0),
        //               SizedBox(width: 4.0),
        //               Text(dateString),
        //             ],
        //           ),
        //           SizedBox(height: 4.0),
        //           Row(
        //             children: [
        //               Icon(Icons.location_pin, size: 16.0),
        //               SizedBox(width: 4.0),
        //               Text(locationString),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      