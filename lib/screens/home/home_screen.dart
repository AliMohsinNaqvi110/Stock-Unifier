import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/authentication/authenticate.dart';
import 'package:inventory_management/screens/home/distributor/distributor_wrapper.dart';
import 'package:inventory_management/screens/home/vendor_wrapper.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // All other connection states other than the above
          else {
            if (user == null && !snapshot.hasData) {
              return const Authenticate();
            }
            // notepad data goes here
            else {
              var _items = snapshot.data;
              if ((_items as dynamic)["role"] == "Distributor"
                  /*&& (_items as dynamic)["Authenticated"] == "Approved"*/
              ) {
                // Display UI for Distributor
                return const DistributorWrapper();
                //return const AdminHome();
              } else if ((_items as dynamic)["role"] == "Vendor"
                  /*&& (_items as dynamic)["Authenticated"] == "Approved"*/
              ) {
                // Display UI for user
                // TODO Here we will show a different widget tree for the user of type Vendor
                return const VendorWrapper();
              }
              // in case of error, if nothing returns
              else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          } // end of else block for other connection states
        }
    );
  }
}
