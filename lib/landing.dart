import 'package:flutter/material.dart';

import './utils.dart';
import './authentication_service.dart';

class Landing extends StatelessWidget {
  checkUser(context) async {
    var result = await AuthenticationService().checkIfUserIsLoggedIn();
    if (result != null && result) {
      Navigator.of(context).pushNamed('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    this.checkUser(context);

    return Scaffold(
        backgroundColor: Color(parseColor("#F8F8F8")),
        body: Center(
            child: Container(
                child: Padding(
          padding: EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Let's plant with us",
                style: TextStyle(fontSize: 26),
              ),
              SizedBox(height: 8),
              Text("make the world green again",
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 36),
              Image.asset('assets/gardener.jpg'),
              SizedBox(height: 48),
              getSignInButton(context),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: Text(
                  "Create an account",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ))));
  }

  Widget getSignInButton(context) {
    return Container(
        margin: EdgeInsets.fromLTRB(36, 0, 36, 0),
        child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                color: Color(parseColor("#67b666")),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))));
  }
}
