import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/models/items_model.dart';
import 'package:inventory_management/models/selected_items_model.dart';
import 'package:inventory_management/screens/home/vendor/checkout.dart';
import 'package:inventory_management/widgets/item_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrowseInventory extends StatefulWidget {
  const BrowseInventory({Key? key}) : super(key: key);

  @override
  State<BrowseInventory> createState() => _BrowseInventoryState();
}

class _BrowseInventoryState extends State<BrowseInventory> {
  Apptheme th = Apptheme();
  String distributorUid = "6mmaMLbY6iS2eiOAWbmJkduDBgH3";

  @override
  void initState() {
    super.initState();
    _loadDistributorIdFromSharedPreferences();
  }

  Future<void> _loadDistributorIdFromSharedPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    String? savedDistributorId = prefs.getString('distributor_uid');

    if (savedDistributorId != null) {
      setState(() {
        distributorUid = savedDistributorId;
      });
    } else {
      log('Distributor ID not found in SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = Provider.of<SelectedItems>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: th.kDarkBlue,
        title: const Text("Browse Inventory"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(distributorUid)
                  .collection("inventory")
                  .doc(distributorUid)
                  .collection("items")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  dynamic data = snapshot.data!.docs;
                  log(data.toString());
                  List<Items> items = snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        (doc.data() as Map<String, dynamic>);
                    return Items.fromMap(data);
                  }).toList();
                  log(items.toString());
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        bool isSelected = false;
                        for (var selectedItem in selectedItems.selectedItems) {
                          if (selectedItem.itemId == items[index].itemId) {
                            isSelected = true;
                            break;
                          }
                        }
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedItems
                                  .removeSelectedItem(items[index].itemId);
                            } else {
                              selectedItems.addSelectedItem(Items(
                                  category: items[index].category,
                                  name: items[index].name,
                                  price: items[index].price,
                                  quantity: 1,
                                  itemId: items[index].itemId));
                            }
                          },
                          child: ItemTile(
                            itemName: items[index].name,
                            quantity: items[index].quantity,
                            price: items[index].price,
                            selected: isSelected,
                            itemId: items[index].itemId,
                            category: items[index].category,
                          ),
                        );
                      });
                } else {
                  return const Text("Something went wrong");
                }
              }),
          Visibility(
            visible: selectedItems.selectedItems.isNotEmpty,
            child: Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(color: th.kDarkBlue, boxShadow: [
                  BoxShadow(
                      offset: (Offset.fromDirection(1.0)),
                      blurRadius: 10,
                      color: th.kLightGrey,
                      spreadRadius: 10)
                ]),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Rs: ",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: selectedItems.totalPrice.toString(),
                                      style: TextStyle(
                                          color: th.kYellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ]),
                          ),
                          Text(
                            "Items Selected: ${selectedItems.selectedItemCount.toString()} pcs",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Checkout()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: th.kLemon,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            "Checkout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
