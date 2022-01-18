import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_management/Screens/home/add_items.dart';
import 'package:inventory_management/Screens/home/cart.dart';
import 'package:inventory_management/Screens/home/categories.dart';
import 'package:inventory_management/Screens/home/sales_history.dart';
import 'package:inventory_management/constants/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Apptheme th = Apptheme();
  PageController controller = PageController();
  int _selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
            children: const [
              Categories(),
              AddItems(),
              Cart(),
              SalesHistory(),
            ],
            onPageChanged: (page) {
            setState(() {
              _selectedIndex = page;
            });
            },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: GNav(
            tabActiveBorder: Border.all(color: th.klemon, width: 1), // tab button border
            curve: Curves.easeInCirc,
            tabBorderRadius: 15,
            gap: 8,
            tabBackgroundColor: th.kyellow,
            backgroundColor: th.kgrey,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          tabs: [
            GButton(
              // onPressed: () {
              //   controller.animateToPage(_selectedIndex, duration: const Duration(milliseconds: 200), curve: curve);
              // },
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.add,
              text: 'Add Items',
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.access_time,
              text: 'History',
            )
          ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              controller.animateToPage(_selectedIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear);
            });
          }),
      ),
    );
  }
}

