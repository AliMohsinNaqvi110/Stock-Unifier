import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/authentication/authenticate.dart';
import 'package:inventory_management/screens/home/distributor/distributor_wrapper.dart';
import 'package:inventory_management/screens/home/vendor/vendor_wrapper.dart';
import 'package:inventory_management/support_files/shared_preferences.dart';
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
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else {
            if (user == null && !snapshot.hasData) {
              return const Authenticate();
            }
            else {
              var items = snapshot.data;
              if ((items as dynamic)["role"] == "Distributor"
                  ) {
                // Display UI for Distributor
                return const DistributorWrapper();
              } else if ((items as dynamic)["role"] == "Vendor"
                  ) {
                String vendorId = (items as dynamic)["vendor_id"];
                setPreference("vendor_id", vendorId)
                    .then((_) => log('Vendor Id set successfully'))
                    .catchError((error) => log('Error: $error'));
                // Display UI for user Vendor
                return const VendorWrapper();
              }
              // in case of error, if nothing returns
              else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          } // end of else block for other connection states
        });
  }
}
