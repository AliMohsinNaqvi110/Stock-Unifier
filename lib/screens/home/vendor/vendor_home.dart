import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/home/vendor/browse_inventory.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:inventory_management/support_files/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/colors.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({Key? key}) : super(key: key);

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  Apptheme th = Apptheme();
  String vendorId =
      "d3ba3e6d-502a-47fe-bfda-9cdd9a82c97e"; // default value to prevent errors
  bool pendingPayments = false;

  @override
  void initState() {
    super.initState();
    _loadVendorIdFromSharedPreferences();
  }

  // Function to retrieve vendor_id from SharedPreferences
  Future<void> _loadVendorIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedVendorId = prefs.getString('vendor_id');

    if (savedVendorId != null) {
      setState(() {
        vendorId = savedVendorId;
      });
    } else {
      log('Vendor ID not found in SharedPreferences.');
    }
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Positioned(
                left: -100,
                top: -65,
                child: CircleAvatar(
                  radius: 188,
                  backgroundColor: th.kDashboardBg,
                ),
              ),
              const Positioned(
                left: -140,
                top: -85,
                child: CircleAvatar(
                  radius: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                left: -120,
                top: -60,
                child: CircleAvatar(
                  radius: 180,
                  backgroundColor: th.kDashboardBg,
                ),
              ),
              Positioned(
                  top: 20,
                  right: 16,
                  child: PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      // popupmenu item 1
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: const [
                            Icon(Icons.help),
                            SizedBox(
                              // sized box with width 10
                              width: 10,
                            ),
                            Text("Help")
                          ],
                        ),
                      ),
                      // popupmenu item 2
                      PopupMenuItem(
                        onTap: () {
                          _auth.signOut();
                        },
                        value: 2,
                        child: Row(
                          children: const [
                            Icon(Icons.logout_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Log out")
                          ],
                        ),
                      ),
                    ],
                    offset: const Offset(0, 50),
                    color: Colors.grey[200],
                    elevation: 2,
                  )),
              // bottom circle
              Positioned(
                right: -120,
                bottom: 50,
                child: CircleAvatar(
                  radius: 132,
                  backgroundColor: th.kDashboardBg,
                ),
              ),
              const Positioned(
                right: -120,
                bottom: 50,
                child: CircleAvatar(
                  radius: 126,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                right: -120,
                bottom: 50,
                child: CircleAvatar(
                  radius: 120,
                  backgroundColor: th.kDashboardBg,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "WELCOME BACK!",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.displayName ?? "User",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5),
                            ),
                            Center(
                              child: FutureBuilder(
                                future: DatabaseService(user.uid)
                                    .getVendorData(vendorId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.connectionState ==
                                          ConnectionState.none) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasData) {
                                    dynamic data = snapshot.data;
                                    if (data.dues > 0) {
                                      setState(() {
                                        pendingPayments = true;
                                      });
                                    }
                                    setPreference("distributor_uid",
                                            data.distributorUid)
                                        .then((value) => log(
                                            "Distributor Uid added to shared preference"));
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: th.kDarkBlue,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Your Account: ",
                                              style: TextStyle(
                                                  color: th.kWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Balance: ",
                                                      style: TextStyle(
                                                          color: th.kWhite,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24),
                                                    ),
                                                    Text(
                                                      "Dues: ",
                                                      style: TextStyle(
                                                          color: th.kWhite,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 8.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Rs. ${data.balance}",
                                                      style: TextStyle(
                                                          color: th.kWhite,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24),
                                                    ),
                                                    Text(
                                                      "Rs. ${data.dues}",
                                                      style: TextStyle(
                                                          color: th.kWhite,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                        child: Text(
                                            "Something went wrong fetching account details"));
                                  }
                                },
                              ),
                            ),
                            // Pending Payments container
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                //overflow: Overflow.visible,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: th.kDashboardLime,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "You're all clear!",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            "0 Pending Payments",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 30,
                                    right: -10,
                                    child: Image(
                                      fit: BoxFit.contain,
                                      height: 100,
                                      width: 220,
                                      image: AssetImage(
                                        "assets/dues_clear_illustration.png",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // New Order container
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BrowseInventory()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  //overflow: Overflow.visible,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: th.kLemon,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Order new items!",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              "Browse the inventory",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 30,
                                      right: -10,
                                      child: Image(
                                        fit: BoxFit.contain,
                                        height: 100,
                                        width: 220,
                                        image: AssetImage(
                                          "assets/shopping.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
