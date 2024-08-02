import 'package:office_spacez/modules/profile/model/ProfileModel.dart';


import 'ApiProvider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Profile> fetchProfile() {
    return _provider.fetchProfile();
  }
}

class NetworkError extends Error {}