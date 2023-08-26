import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/dasshboard_stats.dart';
import 'package:inventory_management/models/items_model.dart';

class DatabaseService {
  DatabaseService(this.uid);

  final String uid;

  //Collection Reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future addUserData(
      {required String userName,
      required String email,
      required String password,
      required String userRole,
      required String? distributorUid}) async {
    if (distributorUid == null) {
      return await userCollection.doc(uid).set({
        "UserName": userName,
        "Email": email,
        "Password": password,
        "Role": userRole
      });
    } else {
      return await userCollection.doc(uid).set({
        "UserName": userName,
        "Email": email,
        "Password": password,
        "Role": userRole,
        "Distributor_Uid": distributorUid
      });
    }
  }

  Future createVendor(
      {required String vendorName,
      required int balance,
      required int dues}) async {
    return await userCollection.doc(uid).collection("vendors").add({
      "name": vendorName,
      "balance": balance,
      "dues": dues,
    });
  }

  /*
    we create empty inventory on user creation to display inventory
     details to user on being redirected to dashboard screen
  * */
  Future createInventory() async {
    return userCollection.doc(uid).collection("inventory").add({
      "total_cost": 0,
      "item_count": 0,
      "profit_earned": 0,
      "monthly_sales": 0,
      "pending_payments": 0,
      "items": [],
      "sales": []
    });
  }

  Future addToInventory(
      String category, String name, int price, int quantity) async {
    try {
      return await userCollection.doc(uid).collection("inventory").add({
        "Category": category,
        "Item_Name": name,
        "Price": price,
        "Quantity": quantity
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // get the items list from inventory collection
  List<Items> _itemsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Items(
          category: doc["category"],
          name: doc["name"],
          price: doc["price"],
          quantity: doc["quantity"],
          totalPrice: doc["total_price"]);
    }).toList();
  }

  /*
     This will not work for vendor, since the inventory will not be available for that user
   */
  //get items stream
  Stream<dynamic> get items {
    final items = userCollection
        .doc(uid)
        .collection("inventory")
        .snapshots()
        .map((event) => event.docs.isNotEmpty
            ? {_itemsListFromSnapshot(event.docs[0].data()['items'])}
            : []);
    return items;
  }

// get the items list from inventory collection
  DashboardStats _statsFromSnapshot(Map<String, dynamic> snapshot) {
    return DashboardStats(
        salesThisMonth: snapshot["monthly_sales"],
        profitEarned: snapshot["profit_earned"],
        pendingPayments: snapshot["pending_payments"],
        itemsInInventory: snapshot["item_count"],
        totalInventoryCost: snapshot["total_cost"]);
  }

  //get items stream
  Stream<DashboardStats> get stats async* {
    final snapshot =
        await userCollection.doc(uid).collection("inventory").get();
    final data = snapshot.docs[0].data(); // Assuming you have only one document

    yield _statsFromSnapshot(data);
  }
}
