import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';


class SalesHistory extends StatefulWidget {
  const SalesHistory({Key? key}) : super(key: key);

  @override
  _SalesHistoryState createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {

  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales History"),
        centerTitle: true,
        backgroundColor: th.kbluish,
      ),
    );
  }
}
