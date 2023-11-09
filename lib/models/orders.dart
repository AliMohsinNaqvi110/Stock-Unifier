import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/items_model.dart';

class Orders {
  String vendorName;
  String orderId;
  String status;
  DateTime date;
  int selectedItemCount;
  int totalPrice;
  List<Items> items;

  Orders(
      {required this.vendorName,
      required this.orderId,
      required this.date,
      required this.selectedItemCount,
      required this.totalPrice,
      required this.items,
      required this.status});

  // Factory constructor to create an Orders instance from a Map
  factory Orders.fromMap(Map<String, dynamic> map) {
    // Assuming 'selectedItems' is the key for the list of items in the map
    List<dynamic> itemsData = map['selectedItems'] ?? [];
    List<Items> itemsList =
        itemsData.map((item) => Items.fromMap(item)).toList();

    return Orders(
      vendorName: map['vendorName'] ?? '',
      orderId: map['orderId'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      selectedItemCount: map['selectedItemCount'] ?? 0,
      totalPrice: map['totalPrice'] ?? 0,
      items: itemsList,
      status: map['status'] ?? '',
    );
  }
}
