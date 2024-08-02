import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:office_spacez/modules/booking_seats/model/floor_availability.dart';
import 'package:office_spacez/networking/client_api.dart';
import 'package:office_spacez/utils/user_state.dart';

part 'booking_seats_event.dart';
part 'booking_seats_state.dart';

class BookingSeatsBloc extends Bloc<BookingSeatsEvent, BookingSeatsState> {
  DateTime dateSelected;
  int floorNoSelected;

  int capacitySelected;
  List<String> users = [];

  final bool status = true;
  String role = "";

  BookingSeatsBloc({
    required this.dateSelected,
    required this.floorNoSelected,
    required this.capacitySelected,
    required this.users,
  }) : super(BookingSeatsInitial()) {
    getRole();
    on<DateModifiedEvent>(_mapDateModifiedEventToState);
    add(DateModifiedEvent());

    on<ConfirmBookingEvent>(_mapConfirmBookingEvent);
  }

  // get user role 
  void getRole() async {
    role = await getUserRole();
    print("Function Bloc: ${role}");
  }

  // When Date is selected update the SeatsAvailabilityTile
  void _mapDateModifiedEventToState(
      BookingSeatsEvent event, Emitter<BookingSeatsState> emit) async {
    emit(SeatsAvailabilityTileLoading());

    // Call client API endpoint w/ this.date parameter
    Map<String, dynamic> response = await getRespFromServer(
      endpoint:
          "seat-booking/availabilityFloorWise/${dateSelected.toIso8601String()}",
      req: HttpType.GET,
    );

    if (response["data"] == null) {
      emit(SeatsAvailabilityTileError());
    } else {
      // Convert the response body into a list of TileModel & store in a variable called - say "modelList"
      emit(SeatsAvailabilityTileSuccess(
          FloorAvailability.fromJson(response["data"])));
    }
  }

  Future<bool> _mapConfirmBookingEvent(
      BookingSeatsEvent event, Emitter<BookingSeatsState> emit) async {
    // Get user email from shared preferences to pass it to payload
    final String email = await getUserEmail();
    print("-------seats-------:$email");

    // Call client API endpoint w/ this.date parameter
    Map<String, dynamic> payload = {
      "date": dateSelected.toIso8601String(),
      "floor_number": floorNoSelected,
      "users": users,
      "token": email,
      "capacity": capacitySelected,
      "status": status
    };
    print(payload);
    Map<String, dynamic> response = await getRespFromServer(
        endpoint: "seat-booking", req: HttpType.POST, params: payload);
    if (response["code"] == RespCode.OK) {
      print(response["code"]);
      return true;
    } else {
      return false;
    }
  }
}
