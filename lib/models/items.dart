
import 'package:flutter/material.dart';

class Items with ChangeNotifier {

  Map<String, dynamic> _selecteditems = {

  };

  String category;
  String name;
  int price;
  int quantity;
  int totalPrice;

  Items([this.category = "",  this.name = "",  this.price =0,  this.quantity = 0 , this.totalPrice = 0]);


  addItems() {
    _selecteditems["ItemName"] = name;
    _selecteditems["Price"] = price;
    _selecteditems["Quantity"] = quantity;
    notifyListeners();
  }

  calculatePriceForEachItem() {
    _selecteditems["Price"] = quantity * price;
    notifyListeners();
  }
}