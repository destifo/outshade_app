import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade_app/data/shared_prefs/SharedPrefService.dart';
import 'package:outshade_app/domain/models/user.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_event.dart';
import 'package:outshade_app/presentation/bloc/login_bloc/login_state.dart';
import 'package:outshade_app/presentation/bloc/user_bloc/users_bloc.dart';
import 'package:outshade_app/presentation/bloc/user_bloc/users_state.dart';
import 'package:outshade_app/presentation/screens/details_screen.dart';
import 'package:outshade_app/presentation/widgets/data_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showDetails(BuildContext ctx) async {
    SharedPrefService prefService = SharedPrefService();
    final name = await prefService.getName();
    final age = await prefService.getAge();
    final gender = await prefService.getGender();

    if (name != null && age != null) {
      Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              name: name,
              age: age.toString(),
              gender: gender!,
            ),
          ));
      BlocProvider.of<LoginBloc>(ctx)
          .add(Login(name: name, age: age, gender: gender!));
    }
  }

  void _signIn(BuildContext ctx, String name) async {
    await showDialog(
      context: ctx,
      builder: (context) {
        return DataForm(
          name: name,
        );
      },
    );
    _showDetails(ctx);
  }

  Future<void> _signOut() async {
    final prefService = SharedPrefService();
    prefService.removeAge();
    prefService.removeGender();
    prefService.removeName();
    prefService.setLoggedinState('loggedout');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            print(state);

            if (state is Checking) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LoggedOut) {
              return BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UsersLoaded) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final User user = state.users[index];

                                return ListTile(
                                  title: Text(user.name),
                                  subtitle: Text(user.atype),
                                  trailing: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.greenAccent)),
                                    onPressed: () {
                                      _signIn(context, user.name);
                                    },
                                    child: const Text(
                                      'Sign in',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }

            if (state is LoggedIn) {
              return Container(
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, userstate) {
                    print(state);
                    if (userstate is UsersLoaded) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.95,
                        child: ListView.builder(
                          itemCount: userstate.users.length,
                          itemBuilder: (context, index) {
                            final User user = userstate.users[index];

                            return GestureDetector(
                              onTap: user.name == state.name
                                  ? () {
                                      _showDetails(context);
                                    }
                                  : () {},
                              child: ListTile(
                                title: Text(user.name),
                                subtitle: Text(user.atype),
                                trailing: user.name == state.name
                                    ? ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () async {
                                          await _signOut();
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(LogOut());
                                        },
                                        child: const Text(
                                          'Log Out',
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              );
            }

            return const Text('Something went wrong');
          },
        ),
      ),
    ));
  }
}
