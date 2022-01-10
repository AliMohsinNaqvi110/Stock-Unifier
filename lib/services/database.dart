import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/models/items.dart';

class DatabaseService {

  DatabaseService(this.uid);
  final String uid;

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

  // List<Items> _itemsFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Items(
  //       category : (doc.data() as dynamic)['Category'] ?? '',
  //       name : (doc.data() as dynamic)['Item_Name'] ?? '',
  //       price : (doc.data() as dynamic)['Price'] ?? "",
  //       quantity : (doc.data() as dynamic)['Quantity'] ?? "",
  //     );
  //   }).toList();
  //   }

  // Items _itemsFromSnapshot(DocumentSnapshot snapshot) {
  //   return Items(
  //     category : (snapshot.data() as dynamic)["Category"],
  //     name : (snapshot.data() as dynamic)["Item_Name"],
  //     price : (snapshot.data() as dynamic)["Price"],
  //     quantity : (snapshot.data() as dynamic)["Quantity"],
  //   );
  // }

  List<Items> _itemsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Items(
        category : (doc.data as dynamic)["Category"],
        name : (doc.data as dynamic)["Item_Name"],
        price : (doc.data as dynamic)["Price"],
        quantity : (doc.data as dynamic)["Quantity"],
      );
    }).toList();
  }

  Stream<List<Items>> get items {
    return userCollection.doc(uid).collection("inventory").snapshots()
        .map(_itemsFromSnapshot);
  }
}