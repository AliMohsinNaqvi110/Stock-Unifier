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
        "user_name": userName,
        "email": email,
        "password": password,
        "role": userRole
      });
    } else {
      return await userCollection.doc(uid).set({
        "user_name": userName,
        "email": email,
        "password": password,
        "role": userRole,
        "distributor_uid": distributorUid
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

  Future createInventory() async {
    return userCollection.doc(uid).collection("inventory").doc(uid).set({
      "total_cost": 0,
      "item_count": 0,
      "profit_earned": 0,
      "monthly_sales": 0,
      "pending_payments": 0,
    });
  }

  Future addToInventory(
      String category, String name, int price, int quantity) async {
    try {
      return await userCollection.doc(uid).collection("inventory").doc(uid).set({
        "category": category,
        "item_name": name,
        "price": price,
        "quantity": quantity
      });
    } catch (e) {
      log(e.toString());
    }
  }

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

  Future<Stream<dynamic>> get items {
    return userCollection
        .doc(uid)
        .get()
        .then((userDoc) {
      if (userDoc.exists) {
        String role = (userDoc.data() as dynamic)['role'];
        if (role == 'Distributor') {
          // User is a Distributor, fetch items from their own inventory
          return userCollection
              .doc(uid)
              .collection("inventory")
              .doc(uid)
              .collection("items")
              .snapshots()
              .map((event) => _itemsListFromSnapshot(event));
        } else if (role == 'Vendor') {
          // User is a Vendor, fetch Distributor's UID from the Vendor's document
          String distributorUID = (userDoc.data() as dynamic)['distributor_uid'];
          // Fetch items from the distributor's inventory using distributorUID
          return userCollection
              .doc(distributorUID)
              .collection("inventory")
              .doc(distributorUID)
              .collection("items")
              .snapshots()
              .map((event) => _itemsListFromSnapshot(event));
        } else {
          // Handle other roles if necessary
          return const Stream.empty();
        }
      } else {
        // Handle the case where the user document does not exist
        return const Stream.empty();
      }
    });
  }

// get the stats from inventory collection
  DashboardStats _statsFromSnapshot(Map<String, dynamic> snapshot) {
    return DashboardStats(
        salesThisMonth: snapshot["monthly_sales"],
        profitEarned: snapshot["profit_earned"],
        pendingPayments: snapshot["pending_payments"],
        itemsInInventory: snapshot["item_count"],
        totalInventoryCost: snapshot["total_cost"]);
  }

  //get stats stream
  Stream<DashboardStats> get stats async* {
    final snapshot =
        await userCollection.doc(uid).collection("inventory").get();
    final data = snapshot.docs[0].data(); // Assuming you have only one document

    yield _statsFromSnapshot(data);
  }
}
