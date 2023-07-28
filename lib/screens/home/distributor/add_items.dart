import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {

  final AuthService _auth = AuthService();
  Apptheme th = Apptheme();
  String _selectedCategory = "";
  String _itemName = "";
  int _quantity = 0;
  int _price = 0;
  final _formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  var categories = [
    "Groceries", "Confectionary", "Snacks", "Beverages", "Medicine", "Cosmetics"
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
        backgroundColor: th.kbluish,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25.0),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.amber
                          ),
                        ),
                          hintText: "Select a category",
                          border: OutlineInputBorder()
                      ),
                      validator: (String? val) {
                        if(val == null || val.trim().length == 0) {
                          return "Please select a category first";
                        }
                        else {
                          return null;
                        }
                      },
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: TextFormField(
                      controller: itemNameController,
                      validator: (String? val) {
                        if(val == null || val.trim().length == 0) {
                          return "Please enter a valid item name";
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Item name",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.amber,
                          )
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _itemName = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price: "),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                            color: th.kyellow,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  child: Icon(Icons.remove),
                                onTap: () {
                                    if(_price == 0) {
                                      return null;
                                    }
                                    else {
                                      setState(() {
                                        _price--;
                                      });
                                    }
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: th.kwhite,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 8.0),
                                    hintText: _price.toString(),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _price = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _price++;
                                  });
                                },
                                  child: Icon(Icons.add)
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity: "),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.60,
                        decoration: BoxDecoration(
                            color: th.kyellow,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                child: Icon(Icons.remove),
                            onTap: () {
                                  if(_quantity == 0) {
                                   return null;
                                  }
                                  else {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                            },),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                color: th.kwhite,
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: TextFormField(
                                controller: quantityController,
                                textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 12),
                                    hintText: _quantity.toString(),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _quantity = int.parse(val);
                                    });
                                  },
                              ),
                            ),
                            InkWell(
                                child: Icon(Icons.add),
                            onTap: () {
                                  setState(() {
                                    _quantity++;
                                  });
                            },),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.20,
                      image: AssetImage("assets/add_to_inventory_illustration.png"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if(_formKey.currentState!.validate()) {
                        await DatabaseService(user.uid).addToInventory(_selectedCategory, _itemName, _price, _quantity);
                          categoryController.clear();
                          itemNameController.clear();
                          quantityController.clear();
                          priceController.clear();
                      }
                      else {
                        return;
                      }
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: th.kbluish,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Center(
                          child: Text(
                              "Save",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
