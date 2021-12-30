import 'package:flutter/material.dart';

class ManageInventory extends StatefulWidget {
  const ManageInventory({Key? key}) : super(key: key);

  @override
  _ManageInventoryState createState() => _ManageInventoryState();
}

class _ManageInventoryState extends State<ManageInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Inventory"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Manage Inventory Screen"),
      ),
    );
  }
}
