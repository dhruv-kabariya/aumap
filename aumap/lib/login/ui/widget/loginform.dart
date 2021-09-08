import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  LoginForm({
    Key key,
    @required this.authBloc,
  })  : assert(authBloc != null),
        super(key: key);
  AuthenticationBloc authBloc;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPas = true;
  TextEditingController _userId;
  TextEditingController _password;
  LoginBloc bloc;

  @override
  void initState() {
    _userId = TextEditingController();
    _password = TextEditingController();
    bloc = LoginBloc(widget.authBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.only(top: 2, left: 3, right: 3, bottom: 2),
                      child: TextFormField(
                        controller: _userId,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline),
                            fillColor: Colors.grey,
                            border: InputBorder.none,
                            hintText: "Enter UserID or Phone"),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.only(top: 2, left: 3, right: 3, bottom: 5),
                      child: TextFormField(
                        controller: _password,
                        obscureText: _showPas,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  _showPas = (!_showPas);
                                });
                              }),
                          fillColor: Colors.grey,
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextButton(
                        onPressed: () {
                          bloc.add(
                            LoginWithCred(_userId.text, _password.text),
                          );
                        },
                        child: Container(
                          color: Color(0xfffc3147),
                          alignment: Alignment.center,
                          child: state == LoginLoading()
                              ? CircularProgressIndicator()
                              : Text("Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 8),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //         child: Divider(),
                    //       ),
                    //       Text(
                    //         "OR",
                    //       ),
                    //       Expanded(
                    //         child: Divider(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   height: 50,
                    //   margin: EdgeInsets.only(top: 12, bottom: 8),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Card(
                    //         shape: CircleBorder(),
                    //         margin: EdgeInsets.only(right: 10),
                    //         elevation: 5,
                    //         child: InkWell(
                    //           onTap: () {
                    //             LoginBloc(
                    //                     authbloc: widget.authBloc,
                    //                     userServices: widget.userServices)
                    //                 .add(LoginWithGoogle());
                    //           },
                    //           child: Image.asset("google.png"),
                    //         ),
                    //       ),
                    //       Card(
                    //         shape: CircleBorder(),
                    //         margin: EdgeInsets.only(left: 10, right: 10),
                    //         elevation: 5,
                    //         child: InkWell(
                    //           onTap: () {
                    //             LoginBloc(
                    //                     authbloc: widget.authBloc,
                    //                     userServices: widget.userServices)
                    //                 .add(LoginWithGoogle());
                    //           },
                    //           child: Container(
                    //             child: Padding(
                    //               padding: EdgeInsets.all(6.0),
                    //               child: Image.asset(
                    //                 "github-logo.png",
                    //                 // fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       InkWell(
                    //         child: Card(
                    //           shape: CircleBorder(),
                    //           margin: EdgeInsets.only(left: 10),
                    //           elevation: 5,
                    //           child: InkWell(
                    //             onTap: () {
                    //               LoginBloc(
                    //                       authbloc: widget.authBloc,
                    //                       userServices: widget.userServices)
                    //                   .add(LoginWithLinkedIn());
                    //             },
                    //             child: Container(
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(9.0),
                    //                 child: Image.asset(
                    //                   "linkedin.png",
                    //                   color: Color(0xff0A66C2),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(left: 50, top: 40, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AuthenticationSignUpForm());
                        },
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
