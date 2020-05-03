import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trini_eats/models/merchant.dart';
import '../models/cart_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthBloc with ChangeNotifier {
  bool _ordersLoading = true;
  FirebaseAuth _auth;
  FirebaseUser _user;
  Firestore _db = Firestore.instance;
  Status _status = Status.Uninitialized;
  Orders _orders;

  bool get ordersLoading => _ordersLoading;
  Orders get orders => _orders;

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
    getOrders();
  }

  //ORDERS//

  void getOrders() {
    print('gettingOrders()');
    _db
        .collection('Users')
        .document(_user.uid)
        .collection('waiting')
        .getDocuments()
        .then((ds) {
      _orders = Orders.fromMap(ds.documents);
      // print(_allMerchants.merchants.length);
      print("orders length: " + _orders.order.length.toString());
      checkForNull();
    });
  }

  void checkForNull() {
    if (_orders != null) {
      _ordersLoading = false;
    }
    notifyListeners();
  }
}
