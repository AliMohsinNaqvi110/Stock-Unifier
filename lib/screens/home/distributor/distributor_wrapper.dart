import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/screens/home/distributor/add_vendor.dart';
import 'package:inventory_management/screens/home/distributor/dashboard.dart';
import 'package:inventory_management/screens/home/distributor/manage_inventory.dart';
import 'package:inventory_management/screens/home/distributor/orders_screen.dart';

class DistributorWrapper extends StatefulWidget {
  const DistributorWrapper({Key? key}) : super(key: key);

  @override
  State<DistributorWrapper> createState() => _DistributorWrapperState();
}

class _DistributorWrapperState extends State<DistributorWrapper> {
  Apptheme th = Apptheme();
  PageController controller = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: controller,
        children: const [
          //first screen will be Dashboard screen
          Dashboard(),
          ManageInventory(),
          // AddItems(),
          AddVendor(),
          OrdersScreen(),
        ],
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(100),
        ),
        child: GNav(
            // tabActiveBorder: Border.all(color: th.klemon, width: 1), // tab button border
            curve: Curves.easeInCirc,
            tabBorderRadius: 100,
            backgroundColor: Colors.transparent,
            // color: Colors.transparent,

            gap: 10,
            tabBackgroundColor: th.kYellow,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.business_center,
                text: 'Inventory',
              ),
              GButton(
                icon: Icons.person_add_alt_1_outlined,
                text: 'Vendors',
              ),
              GButton(
                icon: Icons.list_alt_outlined,
                text: 'Orders',
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                controller.animateToPage(_selectedIndex,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              });
            }),
      ),
    );
  }
}
