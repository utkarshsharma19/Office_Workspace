import 'package:flutter/material.dart';
import 'package:office_spacez/routing/app_routing.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

const AndroidNotificationChannel androidDetails = AndroidNotificationChannel(
  'channel_id',
  'channel_name',
  // 'channel_description',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message
  print(message.notification!.title);
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  // Show notification to user
  showNotification(message);
}

final FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> showNotification(event) async {
  RemoteNotification? notification = event.notification;
  AndroidNotification? androidNotification = event.notification?.android;
  if (notification != null && androidNotification != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidDetails.id,
          androidDetails.name,
          // androidDetails.description,
          color: Colors.orange,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

void registerBackgroundMessageHandler() {
  // messaging.setBackgroundMessageHandler(backgroundHandler);
  messaging.app.setAutomaticDataCollectionEnabled(true);
  FirebaseMessaging.onBackgroundMessage(
      (message) => backgroundHandler(message));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // registerBackgroundMessageHandler();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidDetails);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message.notification!.title);

    // Handle foreground message
    String? title = message.notification!.title;
    String? body = message.notification!.body;
    // Show notification to user
    showNotification(message);
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("message opened app");
      RemoteNotification? notification = event.notification;
      AndroidNotification? androidNotification = event.notification?.android;
      if (notification != null && androidNotification != null) {
        // Doesn't work

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const SampleScreen(),
        //     ),
        //     (route) => false);

        // Can show Dialog instead
        // ShowDialog();
      }
    });

    super.initState();
  }

  final AppRouting appRouting = AppRouting();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the colors used inside app
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(244, 122, 32, 1),
          secondary: Colors.black,
          tertiary: Colors.white,
          background: Color.fromRGBO(247, 247, 247, 1),
        ),

        primaryColor: const Color.fromRGBO(244, 122, 32, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),

        // AppBar Styling
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          // centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
            // size: 30.0,
          ),
          titleTextStyle: TextStyle(
            color: Color.fromRGBO(244, 122, 32, 1),
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),

        // FloatingActionButton styling
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          // iconSize: ,
          foregroundColor: Color.fromRGBO(244, 122, 32, 1),
          backgroundColor: Colors.black,
          iconSize: 48.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),

        // // BottomNavigationBar Styling
        // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //   backgroundColor: Colors.black,
        // ),

        // primarySwatch: Colors.blue,
        // colorScheme: const ColorScheme.light(background: Color.fromRGBO(30, 30, 30, 1)))
        // fontFamily: GoogleFonts.poppins().fontFamily,
      ),

      // Initial Route of the app ////////////////////////////// Initial route of the screen
      initialRoute: '/splash',
      onGenerateRoute: (settings) => appRouting.onGenerateRoute(settings),
    );
  }
}

// MaterialColor buildMaterialColor(Color color) {
//   List strengths = <double>[.05];
//   Map<int, Color> swatch = {};
//   final int r = color.red, g = color.green, b = color.blue;

//   for (int i = 1; i < 10; i++) {
//     strengths.add(0.1 * i);
//   }
//   strengths.forEach((strength) {
//     final double ds = 0.5 - strength;
//     swatch[(strength * 1000).round()] = Color.fromRGBO(
//       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//       1,
//     );
//   });
//   return MaterialColor(color.value, swatch);
// }
