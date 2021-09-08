import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  final AuthenticationBloc authbloc;

  SignUpForm({@required this.authbloc, Key key})
      : assert(authbloc != null),
        super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPas = true;

  TextEditingController _first_name = TextEditingController();
  TextEditingController _last_name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignupBloc bloc = SignupBloc(widget.authbloc);
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // first name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.only(
                                top: 2, left: 10, right: 3, bottom: 2),
                            child: TextFormField(
                              controller: _first_name,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  border: InputBorder.none,
                                  hintText: "First Name"),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.only(
                                top: 2, left: 10, right: 3, bottom: 5),
                            child: TextFormField(
                              controller: _last_name,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                border: InputBorder.none,
                                hintText: "Last Name",
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.only(
                            top: 2, left: 10, right: 3, bottom: 5),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            fillColor: Colors.grey,
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                          validator: (value) {
                            if (!value.contains("@")) {
                              return "Enter Valid Email";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.only(
                            top: 2, left: 10, right: 3, bottom: 5),
                        child: TextFormField(
                          controller: _username,
                          decoration: InputDecoration(
                            fillColor: Colors.grey,
                            border: InputBorder.none,
                            hintText: "Username",
                          ),
                          validator: (value) {
                            if (value.length < 4) {
                              return "Enter Username with lenght > 4";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.only(
                            top: 2, left: 10, right: 3, bottom: 5),
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
                          validator: (value) {
                            if (value.length < 5) {
                              return "Password Length > 5";
                            }
                            return null;
                          },
                        ),
                      ),
                      // Container(
                      //   height: 40,
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey[350],
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   margin: EdgeInsets.symmetric(vertical: 5),
                      //   padding: EdgeInsets.only(
                      //       top: 2, left: 10, right: 3, bottom: 5),
                      //   child: TextFormField(
                      //     controller: _confirmPassword,
                      //     obscureText: _showPas,
                      //     decoration: InputDecoration(
                      //       prefixIcon: Icon(Icons.vpn_key),
                      //       suffixIcon: IconButton(
                      //           icon: Icon(Icons.remove_red_eye),
                      //           onPressed: () {
                      //             setState(() {
                      //               _showPas = (!_showPas);
                      //             });
                      //           }),
                      //       fillColor: Colors.grey,
                      //       border: InputBorder.none,
                      //       hintText: "Confirm Password",
                      //     ),
                      //     validator: (value) {
                      //       if (value != _password.text) {
                      //         return "Enter same password";
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color(0xfffc3147),
                          onPressed: () {
                            bloc.add(SignupWithCred(
                              _username.text,
                              _password.text,
                              _first_name.text,
                              _last_name.text,
                              _email.text,
                            ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: state == SignupLoading()
                                ? CircularProgressIndicator()
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account ! ",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(AuthenticationLoginForm());
                          },
                          child: Text("LogIn",
                              style: Theme.of(context).textTheme.caption),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
