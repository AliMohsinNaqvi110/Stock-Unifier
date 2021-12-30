import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String uid;
  DatabaseService(this.uid);

  //Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference inventoryCollection = FirebaseFirestore.instance.collection("inventory");

  Future updateUserData(String email, String password) async {
    return await userCollection.doc(uid).set({
      "Email" : email,
      "Password" : password
    });
  }

  Future addToInventory(String category, String name, int quantity) async {
    return await inventoryCollection.doc().set({
      "Category" : category,
      "Item_Name" : name,
      "Quantity" : quantity
    });
  }
}