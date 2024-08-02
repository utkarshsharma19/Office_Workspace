

import 'package:equatable/equatable.dart';

import '../model/ProfileModel.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}


class ProfileLoaded extends EventState {
  final Profile profile;
  const ProfileLoaded(this.profile);
}

class EventError extends EventState {
  final String? message;
  const EventError(this.message);
}