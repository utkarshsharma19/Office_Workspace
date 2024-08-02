import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/modules/home/bloc/home_bloc.dart';

class AvailabilitiesCard extends StatelessWidget {
  const AvailabilitiesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // UI - Availabilities          Today
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Availabilities",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Today",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // UI - Ammenities Icons with availability
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, st) {
                var state = st as HomeSuccess;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      // Navigate to the Meeting Room Booking ////////////////////////////// redirect to meeting room booking
                      onTap: () => Navigator.of(context)
                          .pushNamed('/booking_meetingroom'),
                      child: AmmenityIcon(
                        ammenityIcon: Icons.meeting_room,
                        ammenityText: "Meeting Room",
                        availabilityCount:
                            state.homeScreenModel.meetingRoom.toString(),
                      ),
                    ),
                    InkWell(
                      // Navigate to the Seats Booking ////////////////////////////// redirect to seats booking
                      onTap: () =>
                          Navigator.of(context).pushNamed('/booking_seats'),
                      child: AmmenityIcon(
                        ammenityIcon: Icons.workspaces,
                        ammenityText: "Seats",
                        availabilityCount:
                            state.homeScreenModel.seats.toString(),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed('/booking_cafeteria'),
                      child: AmmenityIcon(
                        ammenityIcon: Icons.local_cafe,
                        ammenityText: "Cafeteria",
                        availabilityCount:
                            state.homeScreenModel.cafeteria.toString(),
                      ),
                    ),
                    // AmmenityIcon(
                    //   ammenityIcon: Icons.home,
                    //   ammenityText: "Meeting Rooms",
                    //   availabilityCount: "12",
                    // ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AmmenityIcon extends StatelessWidget {
  const AmmenityIcon({
    required this.ammenityIcon,
    required this.ammenityText,
    required this.availabilityCount,
    super.key,
  });

  final IconData ammenityIcon;
  final String ammenityText, availabilityCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondary,
              child: Icon(
                ammenityIcon,
                size: 40.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            ammenityText,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            availabilityCount,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
