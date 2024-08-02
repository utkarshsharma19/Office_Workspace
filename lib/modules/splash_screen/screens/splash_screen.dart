import 'dart:async';

import 'package:flutter/material.dart';
import 'package:office_spacez/utils/user_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });

    // Handle route based on - if user has logged in 
    Timer(
      const Duration(seconds: 3),
      () async {
        await isLoggedIn()
            ? Navigator.of(context).popAndPushNamed('/home')
            : Navigator.of(context).popAndPushNamed('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/images/office_spacez_logo.png'),
    );
  }
}
