import 'package:flutter/material.dart';

class Items extends ChangeNotifier {
  String? category;
  String? name;
  int? price;
  int? quantity;
  int? totalPrice;

  Items(
      {required this.category,
      required this.name,
      required this.price,
      required this.quantity,
      required this.totalPrice});

/*fromJson(Map<String, dynamic> snapshot) {
    category = snapshot["Category"];
    name = snapshot["Name"];
    price = snapshot["Price"];
    quantity = snapshot["Quantity"];
    totalPrice = snapshot["Total_Price"];
  }*/
}
