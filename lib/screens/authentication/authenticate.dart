import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/authentication/sign_in.dart';
import 'package:inventory_management/Screens/authentication/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;

  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showSignin){
     return Login(toggleView);
    }
    else {
      return SignUp(toggleView);
    }
  }
}
