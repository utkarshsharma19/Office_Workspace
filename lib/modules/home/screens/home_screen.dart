import 'package:office_spacez/modules/home/screens/home_page.dart';
import 'package:office_spacez/modules/my_bookings/screens/my_bookings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  final List<Widget> _screen = [
    HomePage(),
    MyBookingsPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(247, 247, 247, 1),

      // HomeScreen Body with selected tab in BottomNavigationBar
      body: _screen[_selectedIndex],

      // BottomNavigationBar with Home - MyBookings
      bottomNavigationBar: BottomNavigationBar(
        // styling
        // type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.black,

        // selected icon styling
        // selectedFontSize: 20,
        // selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        // selectedItemColor: Theme.of(context).primaryColor,
        // selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        // unselected icon styling
        unselectedIconTheme: const IconThemeData(color: Colors.white),

        onTap: onTabTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Bookings',
          ),
        ],
      ),
    );
  }
}
