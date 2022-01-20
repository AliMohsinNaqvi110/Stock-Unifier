import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Apptheme th = Apptheme();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: th.kbluish,
      ),
      body: Center(
        child: Text("Cart"),
      ),
    );
  }
}
