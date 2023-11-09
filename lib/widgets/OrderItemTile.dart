import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class OrderItemTile extends StatefulWidget {
  final String itemId;
  final String itemName;
  final int quantity;
  final int price;
  final String category;

  OrderItemTile(
      {Key? key,
      required this.itemName,
      required this.quantity,
      required this.price,
      required this.itemId,
      required this.category})
      : super(key: key);

  @override
  State<OrderItemTile> createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  bool isEven = false;

  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        tileColor: isEven ? Colors.white : Colors.grey.shade200,
        title: Text(widget.itemName),
        subtitle: Text("Quantity: ${widget.quantity.toString()} Pieces"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Price Rs ${widget.quantity.toString()}"),
        ),
      ),
    );
  }
}
