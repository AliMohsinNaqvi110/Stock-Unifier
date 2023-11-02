import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({Key? key}) : super(key: key);

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
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
                            Text("About")
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
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Center(
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
                                        "Your Account: ",
                                        style: TextStyle(
                                            color: th.kWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Balance: ",
                                                style: TextStyle(
                                                    color: th.kWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "Dues: ",
                                                style: TextStyle(
                                                    color: th.kWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 8.0),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Rs. 20,000",
                                                style: TextStyle(
                                                    color: th.kWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "Rs. 0",
                                                style: TextStyle(
                                                    color: th.kWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
