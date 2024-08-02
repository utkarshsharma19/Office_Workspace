import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:office_spacez/modules/home/bloc/home_bloc.dart';
import 'package:office_spacez/modules/home/model/home_model.dart';
import 'package:office_spacez/modules/home/model/home_screen_model.dart';

class EventsCarouselWithIndicator extends StatefulWidget {
  const EventsCarouselWithIndicator({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EventsCarouselWithIndicatorState();
  }
}

class _EventsCarouselWithIndicatorState
    extends State<EventsCarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> eventsCard(List<Event> events) {
    return events.map(
      (item) {
        String dateString = "${getDate(item.date)}";
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: ListTile(
            // isThreeLine: true,
            contentPadding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
            title: Text(
              "${item.eventName} - $dateString",
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [
                SizedBox(height: 8.0),
                Text(
                  "${item.description}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Row(
            //       children: [
            //         Icon(Icons.access_time_filled, size: 16.0),
            //         SizedBox(width: 4.0),
            //         Text(dateString),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Icon(Icons.info, size: 16.0),
            //         SizedBox(width: 4.0),
            //         Text(item.description),
            //       ],
            //     ),
            //   ],
            // ),
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
        if (state.homeScreenModel.events.isEmpty) {
          return const Center(child: Text("No Bookings Found"));
        } else {
          return Column(
            children: [
              state.homeScreenModel.events.length > 1
                  ? CarouselSlider(
                      items: eventsCard(state.homeScreenModel.events),
                      carouselController: _controller,
                      options: CarouselOptions(
                        // height: 100.0,
                        // disableCenter: true,
                        autoPlay:
                            state.homeScreenModel.events.length > 1 ? true : false,
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
                  : eventsCard(state.homeScreenModel.events)[0],

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.homeScreenModel.events.asMap().entries.map((entry) {
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
