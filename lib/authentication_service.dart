import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail(
      {@required String email, @required String password}) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firebaseAuth
          .currentUser()
          .then((value) => print("there ${value.email}"));

      return user != null;
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future checkIfUserIsLoggedIn() async {
    if (await _firebaseAuth.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future getUser() async {
    var user = await _firebaseAuth.currentUser();
    return user;
  }

  Future signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
