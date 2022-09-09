abstract class LoginEvent {}

class Login extends LoginEvent {
  final String name;
  final double age;
  final String gender;

  Login({required this.name, required this.age, required this.gender});
}

class LogOut extends LoginEvent {}

class CheckState extends LoginEvent {}