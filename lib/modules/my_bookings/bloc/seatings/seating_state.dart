import 'package:equatable/equatable.dart';

import '../../model/seating_model.dart';

abstract class SeatingState extends Equatable {
  const SeatingState();

  @override
  List<Object?> get props => [];
}

class SeatingInitial extends SeatingState {}

class SeatingLoading extends SeatingState {}

class SeatingLoaded extends SeatingState {
   List<SeatingClass> meetingList;
   SeatingLoaded({required this.meetingList});
}

class SeatingError extends SeatingState {
  final String? message;
  const SeatingError(this.message);
}