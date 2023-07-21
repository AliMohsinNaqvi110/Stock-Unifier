import 'package:flutter/material.dart';

class Items extends ChangeNotifier {

  String? category;
  String? name;
  int? price;
  int? quantity;
  int? totalPrice;

  fromJson(Map<String, dynamic> snapshot) {
    category = snapshot["Category"];
    name = snapshot["Name"];
    price = snapshot["Price"];
    quantity = snapshot["Quantity"];
    totalPrice = snapshot["Total_Price"];
  }

  // Items([this.category = "",  this.name = "",  this.price =0,  this.quantity = 0 , this.totalPrice = 0]);

}