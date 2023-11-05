import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/models/selected_items_model.dart';
import 'package:provider/provider.dart';

class QuantityController extends StatefulWidget {
  final String itemId;

  const QuantityController({Key? key, required this.itemId}) : super(key: key);

  @override
  _QuantityControllerState createState() => _QuantityControllerState();
}

class _QuantityControllerState extends State<QuantityController> {
  Apptheme th = Apptheme();
  late int _selectedQuantity;

  @override
  void initState() {
    super.initState();
    _selectedQuantity = Provider.of<SelectedItems>(context, listen: false).getItemQuantity(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = Provider.of<SelectedItems>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: th.kLemon,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () {
                if (_selectedQuantity == 0) {
                  return;
                } else {
                  setState(() {
                    _selectedQuantity--;
                  });
                  selectedItems.decreaseItemQuantity(widget.itemId);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.remove, size: 20),
              )),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              _selectedQuantity.toString(),
              style: TextStyle(
                  color: Colors.grey.shade800, fontWeight: FontWeight.bold),
            ),
          ),
          // IconButton(onPressed: (){}, icon: Icon(Icons.add)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedQuantity++;
                });
                selectedItems.increaseItemQuantity(widget.itemId);
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.add, size: 20),
              )),
        ],
      ),
    );
  }
}
