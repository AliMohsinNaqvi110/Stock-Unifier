import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/models/orders.dart';
import 'package:inventory_management/services/database.dart';
import 'package:inventory_management/widgets/NewOrderTile.dart';
import 'package:provider/provider.dart';

class NewOrdersTab extends StatefulWidget {
  const NewOrdersTab({Key? key}) : super(key: key);

  @override
  State<NewOrdersTab> createState() => _NewOrdersTabState();
}

class _NewOrdersTabState extends State<NewOrdersTab> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<List<Orders>>(
      stream: DatabaseService(user.uid).getOrderStream(status: "new"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          List<Orders> orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: NewOrderTile(
                  order: orders[index],
                ),
              );
            },
          );
        } else {
          return const Center(
              child: Text("You don't have any new orders"));
        }
      },
    );
  }
}
