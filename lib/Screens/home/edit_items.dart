import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edit_Items extends StatefulWidget {

  Edit_Items(this._selectedCategory);
  String _selectedCategory;

  @override
  _Edit_ItemsState createState() => _Edit_ItemsState();
}

class _Edit_ItemsState extends State<Edit_Items> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit " + widget._selectedCategory.toString() + " List"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users")
            .doc(user.uid).collection("inventory")
            .where("Category", isEqualTo: widget._selectedCategory )
            .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: Text("No Items yet"));
          }
          else return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot _items = snapshot.data!.docs[index];
                return ExpansionTile(
                    title: Text(_items["Item_Name"]),
                  collapsedBackgroundColor: Colors.grey.withOpacity(0.3),
                  backgroundColor: Colors.white,
                  children: [
                    Text("Hello World")
                  ],
                );
              });
        },
      ),
    );
  }
}
