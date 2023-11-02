import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/sale.dart';
import 'package:inventory_management/models/vendor.dart';
import 'package:inventory_management/models/dashboard_stats.dart';
import 'package:inventory_management/models/items_model.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  var uuid = const Uuid();

  DatabaseService(this.uid);

  final String uid;
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

  Future<int> getCategoryItemCount(String category) async {
    QuerySnapshot querySnapshot = await userCollection
        .doc(uid)
        .collection("inventory")
        .doc(uid)
        .collection("items")
        .where("category", isEqualTo: category)
        .get();

    int totalCount = 0; // Initialize total count to 0

    for (var doc in querySnapshot.docs) {
      int quantity = doc["quantity"];
      totalCount += quantity; // Add quantity to total count
    }

    return totalCount;
  }


  Future<bool> addOrUpdateItem(Map<String, dynamic> itemData,
      [String? itemId]) async {
    var itemReference = userCollection
        .doc(uid)
        .collection("inventory")
        .doc(uid)
        .collection("items");

    try {
      if (itemId != null) {
        await itemReference.doc(itemId).update(itemData);
      } else {
        await itemReference.doc(uuid.v4()).set(itemData);
      }
      await updateInventoryStats();
      return true;
    } catch (e) {
      log("Error occurred: $e");
      return false;
    }
  }

  void markItemAsSold(String itemId, int quantity) {
    userCollection
        .doc(uid)
        .collection("inventory")
        .doc(uid)
        .collection("items")
        .doc(itemId)
        .get()
        .then((doc) {
      int currentQuantity = doc["quantity"];
      if (currentQuantity > quantity) {
        userCollection
            .doc(uid)
            .collection("inventory")
            .doc(uid)
            .collection("items")
            .doc(itemId)
            .update({"quantity": currentQuantity - quantity}).then((_) {
          updateInventoryStats();
        });
      } else {
        userCollection
            .doc(uid)
            .collection("inventory")
            .doc(uid)
            .collection("items")
            .doc(itemId)
            .delete()
            .then((_) {
          updateInventoryStats();
        });
      }
    });
  }

  Future<bool> updateInventoryStats() async {
    try {
      var querySnapshot = await userCollection
          .doc(uid)
          .collection("inventory")
          .doc(uid)
          .collection("items")
          .get();

      int totalCount = 0;
      double totalCost = 0;

      for (var doc in querySnapshot.docs) {
        int quantity = doc["quantity"];
        totalCount += quantity;
        totalCost += doc["price"] * quantity;
      }

      await userCollection.doc(uid).collection("inventory").doc(uid).update({
        "item_count": totalCount,
        "total_cost": totalCost,
      });

      log("Inventory count and cost updated successfully!");
      return true; // Operation was successful
    } catch (error) {
      log("Error updating inventory count and cost: $error");
      return false; // Operation failed
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
    return userCollection.doc(uid).get().then((userDoc) {
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
          String distributorUID =
              (userDoc.data() as dynamic)['distributor_uid'];
          return userCollection
              .doc(distributorUID)
              .collection("inventory")
              .doc(distributorUID)
              .collection("items")
              .snapshots()
              .map((event) => _itemsListFromSnapshot(event));
        } else {
          return const Stream.empty();
        }
      } else {
        return const Stream.empty();
      }
    });
  }

  // Create a stream for the sales sub-collection
  Stream<List<Sale>> get salesStream {
    return userCollection
        .doc(uid)
        .collection("inventory")
        .doc(uid)
        .collection("sales")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        // Parse the document data to your Sale model class
        return Sale(
            id: doc["id"],
            itemCount: doc["item_count"],
            totalCost: doc["total_cost"],
            soldDate: doc["sold_date"],
            vendorName: doc["vendor"]);
      }).toList();
    });
  }

// get the stats from inventory collection
  DashboardStats _statsFromSnapshot(Map<String, dynamic> snapshot) {
    return DashboardStats(
        salesThisMonth: snapshot["monthly_sales"],
        profitEarned: snapshot["profit_earned"],
        pendingPayments: snapshot["pending_payments"],
        itemsInInventory: snapshot["item_count"],
        totalInventoryCost: snapshot["total_cost"].toInt());
  }

  //get stats stream
  Stream<DashboardStats> get stats async* {
    final snapshot =
        await userCollection.doc(uid).collection("inventory").get();
    final data = snapshot.docs[0].data();

    yield _statsFromSnapshot(data);
  }

  Stream<List<Vendor>> get vendors async* {
    final snapshot = await userCollection.doc(uid).collection("vendors").get();

    final vendorsList = snapshot.docs
        .map((doc) => Vendor(
              name: doc["name"],
              balance: doc["balance"],
              dues: doc["dues"],
            ))
        .toList();
    yield vendorsList;
  }
}
