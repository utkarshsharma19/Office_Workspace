import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/ApiRepository.dart';
import '../model/MeetingModel.dart';
import 'meeting_state.dart';

abstract class MeetingBloc extends Equatable {
  const MeetingBloc();

  @override
  List<Object> get props => [];
}

class GetMeeting extends MeetingBloc {}

class Meeting extends Bloc<MeetingBloc, MeetingState> {
  Meeting() : super(MeetingInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetMeeting>((event, emit) async {
      try {
        emit(MeetingLoading());
        MeetingModel mList = await _apiRepository.fetchMeeting();
        // List<SeatingData> meetingList=[] ;
        // meetingList.add(mList.seatingData);
        
        emit(MeetingLoaded(meetingList: mList.seatingData));

      } on NetworkError {
        emit(MeetingError("Failed to fetch data. is your device online?"));
      }
    });
  }
}