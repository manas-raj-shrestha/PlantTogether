import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';

import '../utils.dart';
import '../authentication_service.dart';
import '../service_locator.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
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
            icon: Icon(Icons.arrow_back, color: Color(parseColor("#67b666"))),
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
                                        color: Color(parseColor("#67b666")))),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: Color(parseColor("#67b666")))),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(32, 16, 32, 32),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(parseColor("#67b666")))),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Color(parseColor("#67b666")))),
                          )),
                      !isLoading
                          ? Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: RaisedButton(
                                  color: Color(parseColor("#67b666")),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      child: Text("Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))),
                                  onPressed: () {
                                    login();
                                    changeLoadingStatus(true);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))))
                          : Container(
                              margin: EdgeInsets.only(bottom: 32),
                              child: JumpingDotsProgressIndicator(
                                fontSize: 40.0,
                                color: Color(parseColor("#67b666")),
                              ))
                    ])))));
  }

  Future login() async {
    var result = await _authenticationService.loginWithEmail(
        email: usernameController.text, password: passwordController.text);

    if (result != null) if (result) {
      changeLoadingStatus(false);
      Navigator.of(context).pushNamed('/dashboard');
    } else {
      changeLoadingStatus(false);
    }
  }

  changeLoadingStatus(bool status) {
    setState(() {
      isLoading = status;
    });
  }
}
