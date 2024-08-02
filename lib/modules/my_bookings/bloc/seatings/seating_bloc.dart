import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/modules/my_bookings/bloc/seatings/seating_state.dart';

import '../../Api/ApiRepository.dart';
import '../../model/seating_model.dart';

abstract class SeatingBloc extends Equatable {
  const SeatingBloc();

  @override
  List<Object> get props => [];
}

class GetSeating extends SeatingBloc {}

class Seating extends Bloc<SeatingBloc, SeatingState> {
  Seating() : super(SeatingInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetSeating>((event, emit) async {
      try {
        emit(SeatingLoading());
        SeatingModel mList = await _apiRepository.fetchSeating();
        emit(SeatingLoaded(meetingList: mList.seatsData));

      } on NetworkError {
        emit(SeatingError("Failed to fetch data. is your device online?"));
      }
    });
  }
}