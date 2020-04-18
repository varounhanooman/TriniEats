import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantMenu {
  final List<MenuItems> menuItems;
  MerchantMenu({this.menuItems});
  factory MerchantMenu.fromMap(List<DocumentSnapshot> docs) {
    var list = docs;
    List<MenuItems> menuItems =
        list.map((f) => MenuItems.fromFirestore(f)).toList();

    return MerchantMenu(menuItems: menuItems);
  }
}

class MenuItems {
  final String id;
  final String category;
  final String image;
  final List items;
  final String name;
  final num price;
  final String merchant;

  MenuItems(
      {this.id, this.category, this.image, this.items, this.name, this.price, this.merchant});

  factory MenuItems.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    var itemList = data['Items'] ?? [];

    return MenuItems(
        id: doc.documentID,
        category: data['Category'] ?? '',
        image: data['Image'] ?? '',
        items: itemList,
        name: data['Name'] ?? '',
        price: data['Price'] ?? 0,
        merchant: data['Merchant'] ?? '')
        ;
  }
}
