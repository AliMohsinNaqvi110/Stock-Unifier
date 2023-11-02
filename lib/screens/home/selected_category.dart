import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/widgets/edit_item_tile.dart';
import 'package:provider/provider.dart';

class SelectedCategory extends StatefulWidget {
  final String selectedCategory;

  const SelectedCategory({required this.selectedCategory, Key? key})
      : super(key: key);

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  Apptheme th = Apptheme();
  bool isEven = false;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: th.kDarkBlue,
          title: const Text("Selected Category"),
          centerTitle: true,

      ),
      body:  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .collection("inventory")
              .doc(user.uid)
              .collection("items")
              .where("category", isEqualTo: widget.selectedCategory)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
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
                      child: EditItemTile(itemName: items["item_name"], price: items["price"], quantity: items["quantity"], isEven: isEven)
                    );
                  });
            } else {
              return const Center(
                child: Text("There aren't any items in this category yet"),
              );
            }
          })
    );
  }
}
