import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Login"),
          onPressed: () async {
            await _auth.signInAnon();
          },
        ),
      ),
    );
  }
}
