import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/modules/profile/bloc/event_state.dart';

import '../Api/ApiRepository.dart';


abstract class ProfileBloc extends Equatable {
  const ProfileBloc();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileBloc {}

class Profile extends Bloc<ProfileBloc, EventState> {
  Profile() : super(EventInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetProfile>((event, emit) async {
      try {
        emit(EventLoading());
        final mList = await _apiRepository.fetchProfile();
        emit(ProfileLoaded(mList));
      } on NetworkError {
        emit(EventError("Failed to fetch data. is your device online?"));
      }
    });
  }
}