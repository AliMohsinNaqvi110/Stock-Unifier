import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_management/Screens/home/add_items.dart';
import 'package:inventory_management/Screens/home/cart.dart';
import 'package:inventory_management/Screens/home/dashboard.dart';
import 'package:inventory_management/Screens/home/sales_history.dart';
import 'package:inventory_management/constants/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Apptheme th = Apptheme();
  PageController controller = PageController();
  int _selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
          children: const [
            Dashboard(),
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
      bottomNavigationBar: GNav(
            tabActiveBorder: Border.all(color: th.klemon, width: 1), // tab button border
            curve: Curves.easeInCirc,
            tabBorderRadius: 24,
            gap: 10,
            tabBackgroundColor: th.kyellow,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          tabs: [
            GButton(
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
    );
  }
}

