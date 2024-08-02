import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:office_spacez/modules/home/model/home_model.dart';
import 'package:office_spacez/modules/home/model/home_screen_model.dart';
import 'package:office_spacez/networking/client_api.dart';
import 'package:office_spacez/utils/user_state.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    getHomeScreenData();
  }

  getHomeScreenData() async {
    // getting userId from shared_preferences
    String email = await getUserEmail();
    emit(HomeLoading());
    Map<String, dynamic> response = await getRespFromServer(
      endpoint: "overall-booking/homescreen_api/$email",
      req: HttpType.GET,
      // params: {"userID": 123456},
    );
    
    if(response["data"] == null){
      emit(HomeError());
    } else {
      emit(HomeSuccess(HomeScreenModel.fromJson(response["data"])));
    }
  }
}
