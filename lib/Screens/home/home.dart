import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/Screens/home/add_items.dart';
import 'package:inventory_management/Screens/home/dashboard.dart';
import 'package:inventory_management/Screens/home/manage_inventory.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';

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
        Dashboard(),
        AddItems(),
        ManageInventory(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home')),
          const BottomNavigationBarItem(
              icon: Icon(Icons.add), label: ('Add Items')),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: ('Manage Inventory')),
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
