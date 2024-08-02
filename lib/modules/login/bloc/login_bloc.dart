import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:office_spacez/networking/client_api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPressed>((event, emit) async {
      // TODO: implement event handler
      emit(LoginLoading());
      Map<String, dynamic> response = await getRespFromServer(
      endpoint: "/user/login",
      req: HttpType.POST,
      // params: {"email": , "password": },
    );
    
    if(response["data"] == null){
      emit(LoginError());
    } else {
      // emit(LoginSuccess(LoginModel.fromJson(response["data"])));
    }
    });
  }

  void onLoginPressed(String email, String password) {

  }
}
