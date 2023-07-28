import 'package:flutter/material.dart';
import 'package:inventory_management/widgets/dashboard_card.dart';
import 'package:inventory_management/widgets/vendor_tile.dart';
import '../../../constants/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        centerTitle: true,
        title: const Text("Dashboard"),
        backgroundColor: th.kbluish,
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.16,
                decoration: BoxDecoration(
                    color: th.kbluish,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 16.0, bottom: 8.0),
                            child: Text(
                              "Welcome Back",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            "Ali Mohsin",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/1077/1077114.png"),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
/*
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    //overflow: Overflow.visible,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: th.kwhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 6)
                              )
                            ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.92,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Vendors",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                              Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "You have 5 vendors in your network",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
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
                          image: AssetImage("assets/vendors.png",),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
*/

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 16,
                        crossAxisCount: 2,
                        mainAxisExtent: 120),
                    children: [
                      DashboardCard(
                        value: "24,250",
                        colors: [Colors.orange, Colors.grey.shade300],
                        text: 'Sales This Month',
                      ),
                      DashboardCard(
                          value: "50,820",
                          colors: [Colors.blueAccent, Colors.grey.shade300],
                          text: 'Items in Inventory'),
                      DashboardCard(
                          value: "Rs. 700,650",
                          colors: [Colors.deepOrangeAccent, Colors.grey.shade300],
                          text: 'Profit Earned'),
                      DashboardCard(
                          value: "Rs. 200,725",
                          colors: [Colors.indigoAccent, Colors.grey.shade300],
                          text: 'Total Inventory Cost'),
                    ],
                  )),
              const SizedBox(height: 30,),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white38,
                        Colors.grey.shade200,
                        Colors.blueGrey.shade100
                      ]
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: VendorTile(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: VendorTile(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: VendorTile(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
