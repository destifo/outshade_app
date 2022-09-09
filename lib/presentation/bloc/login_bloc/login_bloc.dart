import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade_app/data/shared_prefs/SharedPrefService.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_event.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut()) {
    on<CheckState>(_checkState);
    on<Login>(_login);
    on<LogOut>(_logout);
  }

  void _checkState(CheckState event, Emitter emit) async {
    emit(Checking());

    final SharedPrefService prefService = SharedPrefService();
    final String? loginState = await prefService.getLoggedinState();

    if (loginState == null || loginState == 'loggedout') {
      prefService.setLoggedinState('loggedout');
      emit(LoggedOut());
    } else {
      final name = await prefService.getName();
      emit(LoggedIn(name));
    }
  }

  void _login(Login event, Emitter emit) {
    emit(Checking());
    final SharedPrefService prefService = SharedPrefService();

    prefService.setName(event.name);
    prefService.setAge(event.age);
    prefService.setGender(event.gender);
    prefService.setLoggedinState('loggedin');

    emit(LoggedIn(event.name));
  }

  void _logout(LogOut event, Emitter emit) {
    emit(Checking());

    final SharedPrefService prefService = SharedPrefService();
    prefService.setLoggedinState('loggedout');
    prefService.removeAge();
    prefService.removeGender();
    prefService.removeName();

    emit(LoggedOut());
  }
}
