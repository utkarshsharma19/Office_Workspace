import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/modules/my_bookings/bloc/seatings/seating_bloc.dart';
import 'package:office_spacez/modules/my_bookings/bloc/seatings/seating_state.dart';
import 'package:office_spacez/modules/my_bookings/screens/cafeteria_screen.dart';
import 'package:office_spacez/modules/my_bookings/screens/seatings_screen.dart';

import 'meeting_screen.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom:  TabBar(
            labelColor: Color.fromRGBO(244, 122, 32, 1),
            indicatorColor: Color.fromRGBO(244, 122, 32, 1),
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text('Seatings')
              ),
              Tab(
                child: Text('Meeting Rooms'),
              ),
              Tab(
                child: Text('Cafeteria'),
              ),
            ],
          ),
          title: const Text('My Bookings'),
        ),
        body: const TabBarView(
          children: [
            SeatingPage(),
            MeetingPage(),
            // CafeteriaPage()
          ],
        ),
      ),
    );
  }
}
