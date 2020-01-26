import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthBloc with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  AuthBloc.instance() : _auth = FirebaseAuth.instance {
    print("here");
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future signOut(context) async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      print(_user.email);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
