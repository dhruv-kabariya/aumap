import 'package:aumap/authentication/ui/screen/Authscreen.dart';
import 'package:aumap/blocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'screen/mainscreen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(AuMap());
}

class AuMap extends StatelessWidget {
  AuMap({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
      ], child: HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            return MainScreen();
          } else {
            return AuthenticationScreen();
          }
        });
  }
}
