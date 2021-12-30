import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthService _auth = AuthService();
  String _selectedCategory = "";
  String _itemName = "";
  int _quantity = 0;
  final categoryController = TextEditingController();
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();

  var categories = [
    "Groceries", "Confectionary", "Health care", "Utilities"
  ];

  @override
  void dispose() {
    categoryController.dispose();
    itemNameController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
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
              /*  TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    hintText: "Enter Category",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _category = val;
                    });
                  },
                ),*/
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
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter Quantity",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _quantity = int.parse(val);
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      await DatabaseService(user.uid).addToInventory(_selectedCategory, _itemName, _quantity);
                      categoryController.clear();
                      itemNameController.clear();
                      quantityController.clear();
                    },
                    child: Text("Insert item to inventory"))
              ],
            ),
          ),
        )
      ),
    );
  }
}
