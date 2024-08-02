import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:office_spacez/networking/client_api.dart';
import 'package:office_spacez/utils/user_state.dart';
import '../model/ProfileModel.dart';


class ApiProvider {
  


  Future<Profile> fetchProfile() async {
    late var profile;
    String userId = await getUserId();
    String endpoint = 'user/$userId';

    final response = await getRespFromServer(endpoint: endpoint, req: HttpType.GET);
    print(response["data"]);
    if (response["code"] == 200) {
      // final jsonList = json.decode(response["data"]);
      profile = Profile.fromJson(response['data']);
    }
    return profile;
  }
}