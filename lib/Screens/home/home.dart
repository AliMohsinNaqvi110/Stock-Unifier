import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/home/add_items.dart';
import 'package:inventory_management/Screens/home/categories.dart';
import 'package:inventory_management/Screens/home/dashboard.dart';
import 'package:inventory_management/Screens/home/cart.dart';
import 'package:inventory_management/Screens/home/sales_history.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        Categories(),
        AddItems(),
        Cart(),
        SalesHistory(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo[800],
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home')),
          const BottomNavigationBarItem(
              icon: Icon(Icons.add), label: ('Add Items')),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: ('Cart')),
          const BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined), label: ('Sales History')),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
