import 'package:office_spacez/modules/booking_meetingroom/screens/booking_meetingroom.dart';
import 'package:office_spacez/modules/booking_seats/screens/booking_seats.dart';
import 'package:office_spacez/modules/home/screens/home_screen.dart';
import 'package:office_spacez/modules/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:office_spacez/modules/profile/screens/profile_screen.dart';
import 'package:office_spacez/modules/splash_screen/screens/splash_screen.dart';

import '../modules/booking_cafeteria/screens/booking-cafeteria-screen.dart';

class AppRouting {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/booking_meetingroom':
        return MaterialPageRoute(builder: (_) => const BookingMeetingRoom());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/booking_seats':
        return MaterialPageRoute(builder: (_) => const BookingSeats());
      case '/booking_cafeteria':
        return MaterialPageRoute(builder: (_) => const BookCafeRoom());
      // case '/signup':
      //   return MaterialPageRoute(builder: (_) => const SignupPage());
    }
    return null;
  }
}
