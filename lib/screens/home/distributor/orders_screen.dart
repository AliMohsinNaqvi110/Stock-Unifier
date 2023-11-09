import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/screens/home/distributor/AcceptedOrdersTab.dart';
import 'package:inventory_management/screens/home/distributor/NewOrdersTab.dart';
import 'package:inventory_management/screens/home/distributor/CompletedOrdersTab.dart';

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
            NewOrdersTab(),
            AcceptedOrdersTab(),
            CompletedOrdersTab(),
          ],
        ),
      ),
    );
  }
}
