import 'package:equatable/equatable.dart';
import 'package:office_spacez/modules/my_bookings/model/MeetingModel.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();

  @override
  List<Object?> get props => [];
}

class MeetingInitial extends MeetingState {}

class MeetingLoading extends MeetingState {}

class MeetingLoaded extends MeetingState {
  List<SeatingData> meetingList;
   MeetingLoaded({required this.meetingList});
}

class MeetingError extends MeetingState {
  final String? message;
  const MeetingError(this.message);
}