import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/models/vendor.dart';
import 'package:inventory_management/models/dashboard_stats.dart';
import 'package:inventory_management/screens/home/distributor/add_vendor.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:inventory_management/widgets/dashboard_card.dart';
import 'package:inventory_management/widgets/vendor_tile.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Apptheme th = Apptheme();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            //alignment: Alignment.center,
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
                  child: InkWell(
                    onTap: () {
                      _auth.signOut();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[400],
                      radius: 28,
                      backgroundImage: const NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/1077/1077114.png"),
                    ),
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
              Column(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  // no. of Sales Container
                  StreamBuilder<DashboardStats>(
                    stream: DatabaseService(user.uid).stats,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        dynamic data = snapshot.data;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kDarkBlue,
                                    borderRadius: BorderRadius.circular(18)),
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.salesThisMonth.toString(),
                                      style: TextStyle(
                                          color: th.kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Sales This Month",
                                      style: TextStyle(
                                          color: th.kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20.0),
                                child: GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 16,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 120),
                                  children: [
                                    // Profit Earned
                                    DashboardCard(
                                        value: data.profitEarned.toString(),
                                        color: th.kDashboardLime,
                                        text: 'Profit Earned'),
                                    DashboardCard(
                                        value: data.profitEarned.toString(),
                                        color: th.kDashboardMustard,
                                        text: 'Pending payments'),
                                    DashboardCard(
                                      value: data.itemsInInventory.toString(),
                                      color: th.kDashboardCyan,
                                      text: 'Items in Inventory',
                                    ),
                                    DashboardCard(
                                        value:
                                            data.totalInventoryCost.toString(),
                                        color: th.kDashboardPurple,
                                        text: 'Total Inventory Cost'),
                                  ],
                                )),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  StreamBuilder<List<Vendor>>(
                      stream: DatabaseService(user.uid).vendors,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          dynamic data = snapshot.data;
                          return Center(
                              child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Vendors",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22),
                                ),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    shape: BoxShape.rectangle,
                                    color: th.kDarkBlue,
                                  ),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: data.length,
                                      itemBuilder: (context, index) => Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0),
                                                child: VendorTile(
                                                  name: data[index].name,
                                                  balance: data[index].balance.toString(),
                                                  dues: data[index].dues.toString(),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Divider(
                                                  thickness: 0.8,
                                                  color: th.kWhite,
                                                ),
                                              )
                                            ],
                                          ))),
                            ],
                          ));
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AddVendor();
                                }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kDarkBlue,
                                    borderRadius: BorderRadius.circular(18)),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No vendors found",
                                      style: TextStyle(
                                          color: th.kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Click here to create a new vendor account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: th.kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
