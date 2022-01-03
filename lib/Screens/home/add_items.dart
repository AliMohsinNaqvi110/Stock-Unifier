import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {

  AuthService _auth = AuthService();
  String _selectedCategory = "";
  String _itemName = "";
  int _quantity = 0;
  int _price = 0;
  final categoryController = TextEditingController();
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  var categories = [
    "Groceries", "Confectionary", "Health care", "Utilities"
  ];

  @override
  void dispose() {
    categoryController.dispose();
    itemNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap:  () {
              _auth.signOut();
            },
            child: Icon(
                Icons.exit_to_app
            ),
          )
        ],
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        hintText: "Select a category",
                        border: OutlineInputBorder()
                    ),
                    onChanged: (val) {
                      setState(() {
                        _selectedCategory = val.toString();
                      });
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        child: new Text(category),
                        value: category,
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    controller: itemNameController,
                    decoration: InputDecoration(
                      hintText: "Enter Item name",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _itemName = val;
                      });
                    },
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "Enter Price",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _price = int.parse(val);
                      });
                    },
                  ),
                  NumberInputWithIncrementDecrement(
                    numberFieldDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Quantity",
                      labelText: "Quantity",
                    ),
                    controller: quantityController,
                    min: 0,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          await DatabaseService(user.uid).addToInventory(_selectedCategory, _itemName, _price, _quantity);
                          categoryController.clear();
                          itemNameController.clear();
                          quantityController.clear();
                          priceController.clear();
                        },
                        child: Text("Insert item to inventory")),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
