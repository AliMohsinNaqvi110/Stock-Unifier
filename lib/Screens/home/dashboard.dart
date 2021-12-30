import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
          actions: [
          InkWell(
            child: Icon(
              Icons.exit_to_app
            ),
          onTap:  () {
            _auth.signOut();
            },
          )]
      ),
      body: Center(
        child: Text("Dashboard Screen"),
      ),
    );
  }
}
