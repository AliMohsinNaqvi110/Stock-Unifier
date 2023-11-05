import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/widgets/quantity_controller.dart';

class ItemTile extends StatefulWidget {
  final String itemId;
  final String itemName;
  final int quantity;
  final int price;
  final String category;
  final bool selected;

  ItemTile(
      {Key? key,
      required this.itemName,
      required this.quantity,
      required this.price,
      required this.selected,
      required this.itemId,
      required this.category})
      : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
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
          subtitle: Text("Available: ${widget.quantity.toString()} Pieces"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Rs ${widget.quantity.toString()}"),
          ),
          trailing: widget.selected
              ? QuantityController(itemId: widget.itemId)
              : const SizedBox()),
    );
  }
}
