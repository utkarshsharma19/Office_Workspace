part of 'booking_seats_bloc.dart';

@immutable
abstract class BookingSeatsState {}

class BookingSeatsInitial extends BookingSeatsState {}


// States for SeatsAvailabilityTile
class SeatsAvailabilityTileLoading extends BookingSeatsState {}

class SeatsAvailabilityTileSuccess extends BookingSeatsState {
  final FloorAvailability floorAvailabilityModel;

  SeatsAvailabilityTileSuccess(this.floorAvailabilityModel);
}

class SeatsAvailabilityTileError extends BookingSeatsState {}


// States for ConfirmBooking
class ConfirmBookingLoading extends BookingSeatsState {}

class ConfirmBookingSuccess extends BookingSeatsState {}

class ConfirmBookingError extends BookingSeatsState {}