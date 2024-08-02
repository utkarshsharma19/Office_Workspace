import 'package:office_spacez/networking/client_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPref() async {
  return SharedPreferences.getInstance();
}

void setUserInfo({String? email, String? token, String? role}) async {
  final SharedPreferences prefs = await getSharedPref();
  if (email == null || role == null || token == null){
    await prefs.setString('email', '');
    await prefs.setString('role', '');
    await prefs.setString('token', '');
  } else{
    await prefs.setString('email', email);
    await prefs.setString('role', role);
    await prefs.setString('token', token);
  }
}

Future<String> getUserId() async {
  final SharedPreferences prefs = await getSharedPref();
  return prefs.getString('userId') ?? '';
}

Future<String> getUserEmail() async {
  final SharedPreferences prefs = await getSharedPref();
  return prefs.getString('email') ?? '';
}

Future<String> getUserRole() async {
  final SharedPreferences prefs = await getSharedPref();
  return prefs.getString('role') ?? '';
}

Future<String> getUserToken() async {
  final SharedPreferences prefs = await getSharedPref();
  return prefs.getString('token') ?? '';
}

// Check route for Login Screen or Home Screen
Future<bool> isLoggedIn() async {
  final SharedPreferences prefs = await getSharedPref();
  // final String? data =
  //     prefs.getString('token'); // If it doesn't exist, returns null.
  
  // Call some api to check the token validation and return false if statuscode 401
  print("isLoggedIn========================================================");
  final response = await getRespFromServer(endpoint: 'cafeteria-booking/total_availability/date', req: HttpType.GET);
  print(response["data"]);
  print(response["code"]);
  // final data = response["data"];
  if(response["code"] == RespCode.UNAUTHORIZED_ACCESS){
    return false;
  } else {
    return true;
  }


  

  // return (data != null) && data.isNotEmpty ;
}

