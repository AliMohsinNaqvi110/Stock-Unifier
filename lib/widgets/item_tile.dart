import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/widgets/quantity_controller.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final String _selectedCategory;

  ItemTile(this._selectedCategory, {Key? key}) : super(key: key);

  bool isEven = false;

  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("inventory")
            .doc(user.uid)
            .collection("items")
            .where("category", isEqualTo: _selectedCategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    isEven = true;
                  } else {
                    isEven = false;
                  }
                  DocumentSnapshot items = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0),
                    child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        tileColor: isEven
                            ? Colors.white
                            : Colors.grey.withOpacity(0.4),
                        title: Text(items["item_name"]),
                        subtitle: Text("Available: ${items["quantity"]} Pieces"),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Rs ${items["price"]}"),
                        ),
                        trailing: const QuantityController()),
                  );
                });
          } else {
            return const Center(
              child: Text("There aren't any items in this category yet"),
            );
          }
        });
  }
}
