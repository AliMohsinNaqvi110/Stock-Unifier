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
  //List<String> _selectedItems = [];

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
                      // trailing: NumberInputWithIncrementDecrement(
                      //   controller: _quantityController,
                      //   min: 0,
                      // )
                      trailing: Quantity_Controller()
                    ),
                  );
                }
              }
          );
        });

    // return StreamBuilder<List<Items>>(
    //   initialData: null,
    //   stream: DatabaseService(user.uid).items,
    //     builder: (context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasError) {
    //         dynamic _error = snapshot.error;
    //         print(_error);
    //         return const Center(
    //           child: Text("Something went wrong"),
    //         );
    //       }
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: Text("No notice found"),
    //         );
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //     if (snapshot.hasData) {
    //         List<Items> _items = snapshot.data();
    //         return ListView.builder(
    //           itemCount: _items.length,
    //             itemBuilder: (context, index) {
    //              return ListTile(
    //                title: Text(_items[index].category),
    //              );
    //             }
    //         );
    //       }
    //       else return Center(child : Text("Fetching Data"));
    //     }
    // );
  }
}
