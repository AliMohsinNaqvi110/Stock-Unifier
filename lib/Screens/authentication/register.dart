import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';

class Register extends StatefulWidget {

  final void Function() toggleView;
  Register(this.toggleView);


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _email = "";
  String _password = "";
  String _error = "";

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
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
                  validator: (String? val) {
                    if(val == null || val.trim().length == 0) {
                      return "Please enter a valid email";
                    }
                    else {
                      return null;
                    }
                  },
                  // (val) => val!.isEmpty ? 'Enter a valid email' : null,
                  onChanged: (val) {
                    setState(() => _email = val);
                  },
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
                      dynamic result = _auth.register(_email, _password);
                      setState(() => _error = "Enter a valid email or password");
                    }
                  },
                  child: Text("Sign up")),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Text("return to Sign in")),
            ],
          ),
        ),
        ),
      );
  }
}
