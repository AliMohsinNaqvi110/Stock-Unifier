import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {

  final void Function() toggleView;
  Login(this.toggleView);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _email = "";
  String _password = "";
  String _error = "";

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Email",
                  labelText: "Email"
                ),
                onChanged: (val) {
                  setState(() => _email = val);
                },
                validator: (String? val) {
                  if(val == null || val.trim().length == 0) {
                    return "Please enter a valid email";
                  }
                  else {
                    return null;
                  }
                },
                /*(val) => val!.isEmpty ? 'Enter a valid email' : null,*/
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Password",
                    labelText: "Password",
                ),
                validator: (val) => val!.length< 6 ? 'Password must be 6 characters or more' : null,
                onChanged: (val) {
                  setState(() => _password = val);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    dynamic result = _auth.signInWithEmailAndPassword(_email, _password);
                    setState(() => _error = "Enter a valid email or password");
                  }
                },
                child: Text("Sign in")),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "Not a user yet?",
                    style: TextStyle(
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.toggleView();
                  },
                  child: Text(
                    "Click here to sign up",
                    style: TextStyle(
                        fontStyle: FontStyle.italic
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
