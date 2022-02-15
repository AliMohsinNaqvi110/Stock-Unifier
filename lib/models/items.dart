
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Items with ChangeNotifier {

  List<Items> _cart = [

  ];

  String? category;
  String? name;
  int? price;
  int? quantity;
  int? totalPrice;

  Items.fromJson(Map<String, dynamic> snapshot) {
    this.category = snapshot["Category"];
    this.name = snapshot["Category"];
    this.price = snapshot["Category"];
    this.quantity = snapshot["Category"];
    this.totalPrice = snapshot["Category"];
  }

  // Items([this.category = "",  this.name = "",  this.price =0,  this.quantity = 0 , this.totalPrice = 0]);

}