import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';
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
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
                        children: const [
                          Text(
                            "WELCOME BACK!",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Ali Mohsin",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1.5),
                          )
                        ],
                      ),
                    ),
                  ),
                  // no. of Sales Container
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: th.kDarkBlue,
                          borderRadius: BorderRadius.circular(18)),
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "24,260",
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
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 16,
                                crossAxisCount: 2,
                                mainAxisExtent: 120),
                        children: [
                          DashboardCard(
                            value: "50,280",
                            color: th.kDashboardCyan,
                            text: 'Items in Inventory',
                          ),
                          DashboardCard(
                              value: "500,298",
                              color: th.kDashboardLime,
                              text: 'Profit Earned'),
                          DashboardCard(
                              value: "1,200,650",
                              color: th.kDashboardPurple,
                              text: 'Total Inventory Cost'),
                          DashboardCard(
                              value: "200,725",
                              color: th.kDashboardMustard,
                              text: 'Pending payments'),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Vendors",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),),
                  ),
                  Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            shape: BoxShape.rectangle,
                            color: th.kDarkBlue,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 16.0),
                                        child: VendorTile(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Divider(
                                          thickness: 0.8,
                                          color: th.kWhite,
                                        ),
                                      )
                                    ],
                                  ))
                        /*Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: VendorTile(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  thickness: 0.8,
                                  color: th.kWhite,
                                ),
                              )
                            ],
                          ))),*/
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
