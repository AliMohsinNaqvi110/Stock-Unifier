
import 'package:flutter/material.dart';

class Items with ChangeNotifier {
  String category;
  String name;
  int price;
  int quantity;
  int selectedQuantity;

  Items({required this.category, required this.name, required this.price, required this.quantity ,required this.selectedQuantity});
}