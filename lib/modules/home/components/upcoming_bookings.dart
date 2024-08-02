import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:office_spacez/modules/edit_booking_meetingroom/screens/edit_view_meetingroom.dart';
import 'package:office_spacez/modules/home/bloc/home_bloc.dart';
import 'package:office_spacez/modules/home/model/home_model.dart';
import 'package:office_spacez/modules/home/model/home_screen_model.dart';

class UpcomingBookingsCarouselWithIndicator extends StatefulWidget {
  const UpcomingBookingsCarouselWithIndicator({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UpcomingBookingsCarouselWithIndicatorState();
  }
}

class _UpcomingBookingsCarouselWithIndicatorState
    extends State<UpcomingBookingsCarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> upcomingBookingsCard(List<OverallBooking> overallBooking) {
    return overallBooking.map(
      (item) {
        String dateString = "", locationString = "", editRoute = "";
        IconData ammenityIcon = Icons.meeting_room;
        // Update the dateString and locationString based on the type of ammenity
        if (item.amenity == "Meeting Room") {
          dateString =
              "${getDate(item.date)}, ${getTime(item.details[0])} - ${getTime(item.details[1])}";
          locationString =
              "${item.details[4]}, Floor: ${item.details[2]}, Room No: ${item.details[3]}";
          // editRoute = "";
          ammenityIcon = Icons.meeting_room;
        } else if (item.amenity == "Seatings") {
          ammenityIcon = Icons.workspaces;
        }
        return InkWell(
          // Navigate to the Edit Booking ////////////////////////////// redirect to edit booking
          // onTap: () => Navigator.of(context).pushNamed('/edit_booking_meetingroom'),
          onTap: () {
            if (item.amenity == "Meeting Room") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      EditViewMeetingRoom(booking_id: item.bookingId),
                ),
              );
            } else if (item.amenity == "Seatings") {}
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4.0,
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
              leading: ClipRRect(
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
              title: Text(item.amenity, style: TextStyle(fontWeight: FontWeight.w600),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(dateString),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.location_pin, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(locationString),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).toList();
  }

  String getDate(DateTime date) {
    // DateTime date = DateTime.parse(isoString);
    return DateFormat.MMMd().format(date);
  }

  String getTime(isoString) {
    DateTime time = DateTime.parse(isoString);
    return DateFormat.jm().format(time);
  }

  @override
  Widget build(BuildContext context) {
    // return Text("test");
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, st) {
        var state = st as HomeSuccess;
        if (state.homeScreenModel.overallBooking.isEmpty) {
          return const Center(child: Text("No Bookings Found"));
        } else {
          return Column(
            children: [
              state.homeScreenModel.overallBooking.length > 1
                  ? CarouselSlider(
                      items:
                          upcomingBookingsCard(state.homeScreenModel.overallBooking),
                      carouselController: _controller,
                      options: CarouselOptions(
                        // height: 110.0,
                        // disableCenter: true,
                        autoPlay: state.homeScreenModel.overallBooking.length > 1
                            ? true
                            : false,
                        // enlargeCenterPage: true,
                        aspectRatio: 16 / 5,
                        onPageChanged: (index, reason) {
                          setState(
                            () {
                              _current = index;
                            },
                          );
                        },
                      ),
                    )
                  : upcomingBookingsCard(state.homeScreenModel.overallBooking)[0],

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    state.homeScreenModel.overallBooking.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }
}
