// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../Api/ApiRepository.dart';
// import '../../model/cafeteria_model.dart';
// import 'cafeteria_state.dart';
// abstract class CafeteriaBloc extends Equatable {
//   const CafeteriaBloc();

//   @override
//   List<Object> get props => [];
// }

// class GetCafeteria extends CafeteriaBloc {}

// class Cafeteria extends Bloc<CafeteriaBloc, CafeteriaState> {
//   Cafeteria() : super(CafeteriaInitial()) {
//     final ApiRepository _apiRepository = ApiRepository();

//     on<GetCafeteria>((event, emit) async {
//       try {
//         emit(CafeteriaLoading());
//         CafeteriaModel mList = await _apiRepository.fetchCafeteria();
//         List<CafeteriaModel> meetingList=[] ;
//         meetingList.add(mList);
//         meetingList.add(mList);
//         meetingList.add(mList);
//         meetingList.add(mList);
//         meetingList.add(mList);
//         emit(CafeteriaLoaded(meetingList: meetingList));

//       } on NetworkError {
//         emit(CafeteriaError("Failed to fetch data. is your device online?"));
//       }
//     });
//   }
// }