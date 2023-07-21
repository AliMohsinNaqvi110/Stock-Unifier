import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_management/Screens/home/add_items.dart';
import 'package:inventory_management/Screens/home/cart.dart';
import 'package:inventory_management/Screens/home/sales_history.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/screens/home/categories_screen.dart';


// TODO here we will provide new widget tree for the vendor
class VendorWrapper extends StatefulWidget {
  const VendorWrapper({Key? key}) : super(key: key);

  @override
  State<VendorWrapper> createState() => _VendorWrapperState();
}

class _VendorWrapperState extends State<VendorWrapper> {

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
            VendorHome(),
            AddItems(),
            Cart(),
            salesHistory(),
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
              tabBackgroundColor: th.kyellow,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            tabs: const [
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
      ),
    );
  }
}

