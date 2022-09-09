import 'package:outshade_app/domain/models/user.dart';

abstract class UsersState {}

class LoadingUsers extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;

  UsersLoaded(this.users);
}