import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  DatabaseService(this.uid);
  final String uid;

  //Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String userName, String email, String password, String userRole) async {
    return await userCollection.doc(uid).set({
      "userName" : userName,
      "Email" : email,
      "Password" : password,
      "role" : userRole
    });
  }

  Future createVendor(String distributorUid, String vendorName, String email, int balance,  int dues) async {
    return await userCollection.doc(uid).collection("vendors").add({
      "name" : vendorName,
      "email" : email,
      "balance" : balance,
      "dues" : dues,
      "distributor_uid" : distributorUid,
    });
  }

  // Todo this might cause trouble in the future, so we will remove creating empty doc
  Future createInventory(String category, String itemName, int price, int quantity) async {
    return await FirebaseFirestore.instance.collection("users").doc(uid).collection("inventory").add({
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