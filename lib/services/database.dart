import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/models/items.dart';

class DatabaseService {

  final String uid;
  DatabaseService(this.uid);

  //Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  // final CollectionReference inventoryCollection = FirebaseFirestore.instance.collection("inventory");

  Future updateUserData(String email, String password) async {
    return await userCollection.doc(uid).set({
      "Email" : email,
      "Password" : password
    });
  }

  Future createInventory(String category, String itemName, int price, int quantity) async {
    return await FirebaseFirestore.instance.collection("users").doc(uid)..collection("inventory").add({
      "Category" : category,
      "Item_name" : itemName,
      "price" : price,
      "quantity" : quantity
    });
  }

  Future addToInventory(String category, String name, int price, int quantity) async {
    try {
      return await userCollection.doc(uid).collection("inventory").add({
        "Category": category,
        "Item_Name": name,
        "Price" : price,
        "Quantity": quantity
      });
    }
    catch(e) {
      print(e.toString());
    }
  }

/*  //users list from snapshot
  Stream<QuerySnapshot> get items {
    return inventoryCollection.snapshots();
  }*/

  // List<Items> _ItemsListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.docs.map((doc) {
  //     return Items(
  //         (doc.data() as dynamic)['category'] ?? '',
  //       (doc.data() as dynamic)['Item_Name'] ?? '',
  //       (doc.data() as dynamic)['Quantity'] ?? "",
  //     );
  //   }).toList();
  // }

  //get items stream
  // Stream<List<Items>>? get items {
  //   final items = inventoryCollection.snapshots().map((event) => _ItemsListFromSnapshot(event));
  //   return items;
  // }

  /*List<>

  Future getInventory() async {
    try{
      await inventoryCollection.get().then((querysnapshot) {
        querysnapshot.docs.forEach((element) {

        });
      });
    }
    catch(e) {
      print(e.toString());
    }
  }*/

}