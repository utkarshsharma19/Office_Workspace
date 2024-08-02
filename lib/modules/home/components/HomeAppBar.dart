import 'package:flutter/material.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    // Profile Icon
    leading: IconButton(
      icon: const Icon(Icons.account_circle),
      onPressed: () {
        // Route to Profile Screen
        // Navigate to the profile screen ////////////////////////////// redirect to Profile Route
        Navigator.of(context).pushNamed('/profile');
      },
    ),

    // Notification Icon
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          // Route to Notification Screen
        },
      ),
    ],

    titleSpacing: 0.0,

    // App Title
    title: ListTile(
      title: RichText(
        textAlign: TextAlign.left,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold, // Make the text bold
          ),
          children: [
            TextSpan(
              text: 'Hashed',
              style: TextStyle(color: Colors.white),
            ),
            TextSpan(
              text: 'in',
              style: TextStyle(
                color: Color.fromRGBO(244, 122, 32, 1),
              ),
            ),
            TextSpan(
              text: " by Deloitte",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      subtitle: const Text(
        "Bengaluru",
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.w600,
        ),
      ),
    ),
    // title: RichText(
    //   textAlign: TextAlign.center,
    //   text: const TextSpan(
    //     style: TextStyle(
    //       fontSize: 20.0,
    //       fontWeight: FontWeight.w600, // Make the text bold
    //     ),
    //     children: [
    //       TextSpan(
    //         text: 'Office',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //       TextSpan(
    //         text: 'SpaceZ',
    //         style: TextStyle(
    //           color: Color.fromRGBO(244, 122, 32, 1),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  );
}
