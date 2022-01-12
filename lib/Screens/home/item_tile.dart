import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/home/quantity_controller.dart';
import 'package:inventory_management/appTheme.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatefulWidget {

  String _selectedCategory;
  ItemTile(this._selectedCategory, {Key? key}) : super(key: key);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isEven = false;
  Map<String, dynamic> _selectedItems = {
  };

  AppTheme th = AppTheme();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users")
            .doc(user.uid).collection("inventory")
            .where("Category", isEqualTo: widget._selectedCategory )
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  isEven = true;
                }
                else {
                  isEven = false;
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(!snapshot.hasData) {
                  return const Center(
                    child: Text("There aren't any items in this category yet"),
                  );
                }
                else {
                  DocumentSnapshot _items = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedItems["Category"] = _items["Category"];
                          _selectedItems["Name"] = _items["Item_Name"];
                          _selectedItems["Price"] = _items["Price"];
                          _selectedItems["Quantity"] = _items["Quantity"];
                        });
                        print(_selectedItems);
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        tileColor: isEven ? Colors.white : Colors.grey
                            .withOpacity(0.4),
                        title: Text(_items["Item_Name"]),
                        subtitle: Text("Available: " + _items["Quantity"].toString() + " Pieces"),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Rs " + _items["Price"].toString()),
                        ),
                        trailing: Quantity_Controller()
                      ),
                    ),
                  );
                }
              }
          );
        });
  }
}
