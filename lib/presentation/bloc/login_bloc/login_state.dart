abstract class LoginState {}

class LoggedIn extends LoginState {
  final name;
  LoggedIn(this.name);
}

class LoggedOut extends LoginState {}

class Checking extends LoginState {}
