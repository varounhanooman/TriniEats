import 'package:cloud_firestore/cloud_firestore.dart';

class Merchants {
  final List<Merchant> merchants;
  Merchants({this.merchants});

  factory Merchants.fromMap(List<DocumentSnapshot> docs) {
    var list = docs;
    List<Merchant> merchantList =
        list.map((f) => Merchant.fromFirestore(f)).toList();

    return Merchants(merchants: merchantList);
  }
}

class Merchant {
  final String id;
  final String image;
  final List<dynamic> tags;
  final bool display;
  final String name;
  final int ratings;

  Merchant(
      {this.id, this.image, this.tags, this.display, this.name, this.ratings});

  factory Merchant.fromFirestore(DocumentSnapshot doc) {
    // factory Merchant.fromMap(Map data){
    Map data = doc.data;
    var tagsList = data['Tags'] ?? [];
    // data = data ?? {};

    return Merchant(
      id: doc.documentID,
      image: data['Image'] ?? '',
      tags: tagsList,
      display: data['Display'] ?? false,
      name: data['Name'] ?? '',
      ratings: data['Ratings'] ?? 0,
    );
  }
}
