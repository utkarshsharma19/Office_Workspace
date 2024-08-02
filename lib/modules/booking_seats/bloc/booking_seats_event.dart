part of 'booking_seats_bloc.dart';

@immutable
abstract class BookingSeatsEvent {}

class DateModifiedEvent extends BookingSeatsEvent {}

class ConfirmBookingEvent extends BookingSeatsEvent {}