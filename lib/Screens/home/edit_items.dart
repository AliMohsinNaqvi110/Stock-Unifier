import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/Screens/home/quantity_controller.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:provider/provider.dart';

class Edit_Items extends StatefulWidget {

  Edit_Items(this._selectedCategory);
  String _selectedCategory;

  @override
  _Edit_ItemsState createState() => _Edit_ItemsState();
}

class _Edit_ItemsState extends State<Edit_Items> {

  Apptheme th = Apptheme();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: th.kbluish,
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
                  collapsedBackgroundColor: index % 2 == 0 ? th.kwhite : th.klight_grey,
                  backgroundColor: Colors.white,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Price: "),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: th.kyellow
                          ),
                        )
                      ],
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
