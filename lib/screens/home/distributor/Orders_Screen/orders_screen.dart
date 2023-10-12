import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Process Orders"),
          backgroundColor: th.kDarkBlue,
          bottom: const TabBar(
            tabs: [
              Tab(text: "New Orders"),
              Tab(text: "Accepted"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Content for New Orders tab
            Center(child: Text('New Orders Content')),
            // Content for Accepted Orders tab
            Center(child: Text('Accepted Orders Content')),
            // Content for Completed Orders tab
            Center(child: Text('Completed Orders Content')),
          ],
        ),
      ),
    );
  }
}
