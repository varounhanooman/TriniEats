import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final List<Order> order;
  Orders({this.order});

  factory Orders.fromMap(List<DocumentSnapshot> docs) {
    var list = docs;
    List<Order> orderList = list.map((f) => Order.fromFirestore(f)).toList();

    return Orders(order: orderList);
  }
}

class Order {
  final String customerEmail;
  final String customerId;
  final String customerName;
  final String id;
  final List items;
  final Timestamp orderTime;
  final String orderType;
  final String merchant;
  final String status;
  final String statusDescription;
  final num total;

  Order(
      {this.customerEmail,
      this.customerId,
      this.customerName,
      this.id,
      this.items,
      this.merchant,
      this.orderTime,
      this.orderType,
      this.status,
      this.statusDescription,
      this.total});

  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Order(
        customerEmail: data['customer_email'],
        customerId: data['customer_id'],
        customerName: data['customer_name'],
        id: data['id'],
        items: data['items'],
        merchant: data['merchant'],
        orderTime: data['order_time'],
        orderType: data['order_type'],
        status: data['status'],
        statusDescription: data['status_description'],
        total: data['total']);
  }
}
