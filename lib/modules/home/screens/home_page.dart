import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/modules/home/bloc/home_bloc.dart';
import 'package:office_spacez/modules/home/components/HomeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_spacez/modules/home/components/availabilities_card.dart';
import 'package:office_spacez/modules/home/components/events.dart';
import 'package:office_spacez/modules/home/components/upcoming_bookings.dart';
import 'package:office_spacez/modules/my_bookings/screens/my_bookings_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> upcomingBookings = ['Upcoming Booking 1'];

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // HomeScreen AppBar
      appBar: homeAppBar(context),

      // Write Home Page code here
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return const Center(child: Text("Initial"));
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccess) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --------------------Upcoming Bookings--------------------
                    // UI - Upcoming Bookings        (see all>)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HeadingText(heading: "Upcoming Bookings"),
                        // see all> button
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MyBookingsPage(),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Text(
                                'See all >',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    // UI - Upcoming Bookings Carousel slider
                    const UpcomingBookingsCarouselWithIndicator(),

                    const SizedBox(height: 16.0),

                    // -------------------- Events --------------------
                    // UI - Events
                    const HeadingText(heading: "Events"),

                    const SizedBox(height: 12.0),

                    // UI - Events Carousel slider
                    const EventsCarouselWithIndicator(),

                    const SizedBox(height: 16.0),

                    // -------------------- Availabilities --------------------
                    const AvailabilitiesCard(),

                    // CarouselSlider(
                    //   options: CarouselOptions(height: 400.0),
                    //   items: [1, 2, 3, 4, 5].map((i) {
                    //     return Builder(
                    //       builder: (BuildContext context) {
                    //         return Container(
                    //             width: MediaQuery.of(context).size.width,
                    //             margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //             decoration: BoxDecoration(color: Colors.amber),
                    //             child: Text(
                    //               'text $i',
                    //               style: TextStyle(fontSize: 16.0),
                    //             ));
                    //       },
                    //     );
                    //   }).toList(),
                    // )
                  ],
                ),
              );
            } else if (state is HomeError) {
              return const Center(child: Text("Error"));
            } else {
              return const Center(child: Center(child: Text("Null")));
            }
          },
        ),
      ),

      // Add Bookings Floating Action Button
      // floatingActionButton: FloatingActionButton(
      //   // Navigate to the Add Booking ////////////////////////////// redirect to Booking Ammenity
      //   // onPressed: () => Navigator.of(context).pushNamed('/add_booking'),
      //   onPressed: () =>
      //       Navigator.of(context).pushNamed('/booking_meetingroom'),
      //   tooltip: 'Add Booking',
      //   child: const Icon(
      //     Icons.add,
      //   ),
      // ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({
    required this.heading,
    super.key,
  });

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/*
body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Bookings',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.orange,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'See all >',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: upcomingBookings.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://example.com/image.jpg'),
                    ),
                    title: Text('Name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time),
                            SizedBox(width: 4.0),
                            Text('10:00 AM'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 4.0),
                            Text('Location Name'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Events',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: upcomingBookings.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                      title: Center(child: Text('Diwali Celebration')),
                      subtitle: Text('Invite to all  Hasher')),
                );
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      'Availabilities',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(
                          selectedDate != null
                              ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                              : 'Choose Date',
                        ),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () {
                          _selectDate(
                              context); // Call the function to show the date picker
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Grid View',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(4, (index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set circular corner radius
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    // Set circular corner radius
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            color: Colors.grey, // Upper part color
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            color: Colors.white, // Lower part color
                            child: const Center(
                              child: Text(
                                'Dummy Text',
                                style: TextStyle(
                                    fontSize: 20), // Set font size to 20
                              ), // Placeholder text
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
*/
