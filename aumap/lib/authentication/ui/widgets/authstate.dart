import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/login/ui/widget/loginform.dart';
import 'package:aumap/signup/ui/signupform.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class CardOptions extends StatelessWidget {
  const CardOptions({
    this.height,
    this.width,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              "Welcome to Ahmedabad University",
              // style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Container(
            height: height - 150,
            width: width,
            margin: EdgeInsets.only(top: 50),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationFail) {
                  if (state.error.isNotEmpty)
                    Toast.show(state.error, context,
                        duration: 3, gravity: Toast.BOTTOM);
                }
              },
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                bloc: BlocProvider.of<AuthenticationBloc>(context),
                builder: (context, state) {
                  if (state is AuthenticationLogin) {
                    return LoginForm(
                      authBloc: BlocProvider.of<AuthenticationBloc>(context),
                    );
                  } else if (state is AuthenticationSignUp) {
                    return SignUpForm(
                      authbloc: BlocProvider.of<AuthenticationBloc>(context),
                    );
                  }
                  return LoginForm(
                    authBloc: BlocProvider.of<AuthenticationBloc>(context),
                  );
                },
              ),
            ),
            // child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
