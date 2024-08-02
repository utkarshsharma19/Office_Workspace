import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:office_spacez/modules/login/data_source/login_screen_data_source.dart';
import 'package:flutter/material.dart';
import 'package:office_spacez/networking/client_api.dart';
import 'package:office_spacez/utils/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  Future<String> setNotification() async {
    final messaging = FirebaseMessaging.instance;
    late NotificationSettings settings;
    try {
      settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print("error");
      }
    }

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
    String? token = await messaging.getToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("fcmtoken", token!);
    print("fcmtoken       ::::             " + token);
    return token;
  }

  Future<bool> login(email, password, token) async {
    final response = await fetchUserInfo(email, password, token);
    print(response);
    print(RespCode.getByValue(response!));
    if (RespCode.getByValue(response) == RespCode.OK) {
      return true;
    } else {
      return false;
    }
  }

  void _onLoginPressed() async {
    // print("onLoginPressed");
    if (_formfield.currentState!.validate()) {
      final token = await setNotification();
      // Perform login action here
      if (await login(emailController.text, passController.text, token)) {
        // Navigate to the home screen ////////////////////////////// redirect to Home Page Route
        Navigator.of(context).popAndPushNamed('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Incorrect Username or Password"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
              key: _formfield,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Office',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Spacez',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      // Text(
                      //   '.',
                      //   style: TextStyle(
                      //       fontSize: 50,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.green),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/employee_login.jpg",
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "Enter Valid Email";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _onLoginPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
