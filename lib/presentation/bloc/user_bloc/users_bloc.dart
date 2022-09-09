import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade_app/data/data_providers/mock_data_provider.dart';
import 'package:outshade_app/domain/models/user.dart';
import 'package:outshade_app/presentation/bloc/user_bloc/users_event.dart';
import 'package:outshade_app/presentation/bloc/user_bloc/users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final MockDataProvider mockDataProvider = MockDataProvider();

  UsersBloc() : super(LoadingUsers()) {
    on<LoadUsers>((event, emit) async {
      emit(LoadingUsers());
      final List<User> users = await mockDataProvider.getUsers();
      emit(UsersLoaded(users));
    });
  }
}
