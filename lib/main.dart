import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_event.dart';
import 'package:outshade_app/presentation/bloc/user_bloc/users_bloc.dart';
import 'package:outshade_app/presentation/bloc/user_bloc/users_event.dart';
import 'package:outshade_app/presentation/screens/home_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UsersBloc>(
      create: (_) => UsersBloc()..add(LoadUsers()),
    ),
    BlocProvider<LoginBloc>(
      create: (_) => LoginBloc()..add(CheckState()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
