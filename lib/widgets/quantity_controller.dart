import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class QuantityController extends StatefulWidget {
  const QuantityController({Key? key}) : super(key: key);

  @override
  _QuantityControllerState createState() => _QuantityControllerState();
}

class _QuantityControllerState extends State<QuantityController> {

  Apptheme th = Apptheme();
  int _selectedQuantity = 0;

  @override
  Widget build(BuildContext context) {

    // final items = Provider.of<Items>(context);

    return Container(
      decoration: BoxDecoration(color: th.kLemon,
        borderRadius: BorderRadius.circular(50),),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(onTap: () {
              if(_selectedQuantity == 0) {
                return;
              }
              else {
                setState(() {
                  _selectedQuantity--;
                });
              }
          }, child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(Icons.remove, size: 20),
          )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 20),
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(_selectedQuantity.toString(),
              style: TextStyle(color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold),),),
          // IconButton(onPressed: (){}, icon: Icon(Icons.add)),
          InkWell(onTap: () {
            setState(() {
               _selectedQuantity++;

            });
          }, child: const Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(Icons.add, size: 20),
          )),
        ],
      ),
    );
  }
}
