import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_view_event.dart';
part 'edit_view_state.dart';

class EditViewBloc extends Bloc<EditViewEvent, EditViewState> {
  EditViewBloc() : super(EditViewInitial()) {
    on<EditViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
