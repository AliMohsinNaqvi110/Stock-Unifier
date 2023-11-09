import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/constants/functions.dart';
import 'package:inventory_management/models/selected_items_model.dart';
import 'package:inventory_management/screens/home/vendor/vendor_home.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String distributorUid = "6mmaMLbY6iS2eiOAWbmJkduDBgH3";
  String vendorId = "ddc0b417-7fa6-41b8-bd0d-f3d9bd595d49";

  Apptheme th = Apptheme();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadIdsFromSharedPreferences();
  }

  Future<void> _loadIdsFromSharedPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    String? savedDistributorId = prefs.getString('distributor_uid');
    String? savedVendorId = prefs.getString('vendor_id');

    if (savedDistributorId != null) {
      setState(() {
        distributorUid = savedDistributorId;
      });
    }
    if (savedVendorId != null) {
      setState(() {
        vendorId = savedVendorId;
      });
    } else {
      log('There was a problem loading shared preferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = Provider.of<SelectedItems>(context);
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: th.kDarkBlue,
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Selected Items:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                selectedItems.selectedItemCount.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: th.kDarkGrey),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Total Price:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                selectedItems.totalPrice.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: th.kDarkGrey),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              Map<String, dynamic> orderData = selectedItems.toMap();
              orderData["order_id"] = generateRandomItemId();
              orderData["date"] = DateTime.now();
              orderData["status"] = "new";
              orderData["vendor_name"] = user.displayName;
              orderData["vendor_id"] = vendorId;

              bool result = await DatabaseService(user.uid).createOrder(
                  orderData: orderData,
                  distributorUid: distributorUid,
                  orderId: orderData["order_id"]);
              if (result) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Order Created!",
                    onConfirmBtnTap: () {
                      selectedItems.clearSelectedItems();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VendorHome()));
                    });
              } else {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: "Something went wrong!",
                  // onConfirmBtnTap: () {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const VendorHome()));
                  // }
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                    color: th.kDarkBlue,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Place Order",
                  style: TextStyle(color: th.kWhite),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
