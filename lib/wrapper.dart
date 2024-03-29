import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/authentication/authenticate.dart';
import 'package:inventory_management/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    //Display either the authentication screens or home screen
    if(user == null) {
      return const Authenticate();
    }
      else {
        return const Home();
    }
  }
}
