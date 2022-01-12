import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  String category;
  String itemName;
  int price;
  int itemQuantity;
  CartModel(this.category, this.itemName, this.price, this.itemQuantity);



}