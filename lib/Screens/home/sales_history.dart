import 'package:flutter/material.dart';

class SalesHistory extends StatefulWidget {
  const SalesHistory({Key? key}) : super(key: key);

  @override
  _SalesHistoryState createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales History"),
        centerTitle: true,
      ),
    );
  }
}
