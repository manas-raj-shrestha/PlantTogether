import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';

import '../utils.dart';
import '../authentication_service.dart';
import '../service_locator.dart';
import '../colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  bool isLoading = false;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(parseColor(themeGreen))),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Color(parseColor("#F8F8F8")),
        body: Center(
            child: Container(
                width: 300,
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(32, 32, 32, 0),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(parseColor(themeGreen)))),
                                labelText: "Username",
                                labelStyle: TextStyle(
                                    color: Color(parseColor(themeGreen)))),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(32, 16, 32, 32),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(parseColor(themeGreen)))),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Color(parseColor(themeGreen)))),
                          )),
                      !isLoading
                          ? Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: RaisedButton(
                                  color: Color(parseColor(themeGreen)),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      child: Text("Sign Up",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))),
                                  onPressed: () {
                                    signUp();
                                    changeLoadingStatus(true);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))))
                          : Container(
                              margin: EdgeInsets.only(bottom: 32),
                              child: JumpingDotsProgressIndicator(
                                fontSize: 40.0,
                                color: Color(parseColor(themeGreen)),
                              ))
                    ])))));
  }

  Future signUp() async {
    var result = await _authenticationService.signUpWithEmail(
        email: usernameController.text, password: passwordController.text);

    if (result != null) if (result) {
      writeUserToFireStore();
      // changeLoadingStatus(false);
      Navigator.of(context).pushNamed('/dashboard');
    } else {
      changeLoadingStatus(false);
    }
  }

  Future writeUserToFireStore() async {
    var user = await AuthenticationService().getUser();

    await Firestore.instance
        .collection("users")
        .document(user.email)
        .setData({'email': user.email});

    changeLoadingStatus(false);
  }

  changeLoadingStatus(bool status) {
    setState(() {
      isLoading = status;
    });
  }
}
