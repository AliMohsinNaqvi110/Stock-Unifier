import 'package:cloud_firestore/cloud_firestore.dart';

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
      {
      required String vendorName,
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
  Future createInventory(
      String category, String itemName, int price, int quantity) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("inventory")
        .add({
      "Category": category,
      "Item_name": itemName,
      "price": price,
      "quantity": quantity
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
      print(e.toString());
    }
  }

//get Items stream

// Future getItems() async {
//   try{
//     return await FirebaseFirestore.instance.collection("users").doc(uid).collection("inventory").get().then((querySnapshot) {
//       Items items = Items.fromJson(querySnapshot);
//     });
//   }
//   catch (e) {
//
//   }
//
// }

}
