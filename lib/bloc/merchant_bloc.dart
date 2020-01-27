import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trini_eats/models/merchant.dart';
import 'package:trini_eats/models/merchantmenu.dart';

class MerchantBloc with ChangeNotifier {
  bool _isloading = true;
  Firestore _db = Firestore.instance;
  Merchants _allMerchants;
  MerchantMenu _allMenu;
  int _size;
  num _cartTotal = 0;
  List<MenuItems> _cart = [];

  int get size => _size;
  Merchants get allMerchants => _allMerchants;
  MerchantMenu get allMenu => _allMenu;
  List get cart => _cart;
  bool get isLoading => _isloading;
  num get cartTotal => _cartTotal;

  MerchantBloc.instance() {
    getMerchantData();
  }

  void checkForNull() {
    if (_allMerchants != null) {
      _isloading = false;
    }
    notifyListeners();
  }

  void getMerchantLength() {
    _db.collection('Merchant').getDocuments().then((size) {
      _size = size.documents.length;
      notifyListeners();
    });
  }

  void getMerchantData() {
    print('getMerchantData()');
    _db.collection('Merchant').getDocuments().then((ds) {
      _allMerchants = Merchants.fromMap(ds.documents);
      print(_allMerchants.merchants.length);
      checkForNull();
    });
  }

  getMenuItems(docId) {
    _db
        .collection("Merchant")
        .document(docId)
        .collection("menu")
        .getDocuments()
        .then((ds) {
      _allMenu = MerchantMenu.fromMap(ds.documents);
      notifyListeners();
      // print(_allMenu.menuItems[0].name);
    });
  }

  setCart(item) {
    _cart.add(item);
    _cartTotal = _cartTotal + item.price;
    print(_cartTotal);
    notifyListeners();
  }

  removeFromCart(item){
    _cart.remove(item);
    _cartTotal = _cartTotal - item.price;
    print(_cartTotal);
    notifyListeners();
  }

  // cartTotal() {
  //   cart.forEach((item) {
  //     _cartTotal = _cartTotal + item.price;
  //   });
  // }
}

//   // MerchantBloc.instance() {
//   //   print("get data");
//   //   // getData();
//   //   streamMerchant("KFC");
//   // }

//   Stream<Merchant> streamMerchant(String id) {
//     return _db
//         .collection('KFC')
//         .document(id)
//         .snapshots()
//         .map((snap) => Merchant.fromFirestore(snap));
//   }

//   // / Query a subcollection
//   // Stream<List<Merchant>> streamMerchants() {
//   //   var ref = _db.collection('Merchant');

//   //   return ref.snapshots().map((list) =>
//   //       list.documents.map((doc) => Merchant.fromFirestore(doc)).toList());

//   // }

//   /// Write data
//   // Future<void> createHero(String heroId) {
//   //   return _db.collection('heroes').document(heroId).setData({ /* some data */ });
//   // }

//   void getData() {
//     _db.collection("Merchant").getDocuments().then((QuerySnapshot snapshot) {
//       snapshot.documents.forEach((f) => print('${f.data}}'));
//     });
//   }
// }
