import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class Quantity_Controller extends StatefulWidget {
  const Quantity_Controller({Key? key}) : super(key: key);

  @override
  _Quantity_ControllerState createState() => _Quantity_ControllerState();
}

class _Quantity_ControllerState extends State<Quantity_Controller> {

  Apptheme th = Apptheme();
  int _selectedQuantity = 0;

  @override
  Widget build(BuildContext context) {

    // final items = Provider.of<Items>(context);

    return Container(
      decoration: BoxDecoration(color: th.klemon,
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
