import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/services/auth.dart';

class SignUp extends StatefulWidget {
  final void Function() toggleView;
  const SignUp(this.toggleView, {Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Apptheme th = Apptheme();
  bool _obscureText = true;
  String _userName = "";
  String _email = "";
  String _password = "";
  String _error = "";
  final String _userRole = "Distributor";
  final List<String> _userRoles = ["Distributor", "Vendor"];

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                          color: th.kbluish,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Image(
                    image: AssetImage("assets/login.png"),
                    width: 240,
                    height: 220,
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFF9A826),
                          ),
                          width: MediaQuery.of(context).size.width / 1.10 ,
                          height: MediaQuery.of(context).size.height / 1.80,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  validator: (String? val) {
                                    if(val == null || val.trim().length == 0) {
                                      return "Please enter a valid user name";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() => _userName = val);
                                  },
                                  cursorColor: th.kbluish,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        BorderSide(color: th.klemon)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                        const BorderSide(color: Colors.white)),
                                    hintText: 'User Name',
                                    prefixIcon: Icon(
                                      Icons.account_circle_outlined,
                                      color: th.kbluish,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  validator: (String? val) {
                                    if(val == null || val.trim().length == 0) {
                                      return "Please enter a valid email";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() => _email = val);
                                  },
                                  cursorColor: th.kbluish,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        BorderSide(color: th.klemon)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                        const BorderSide(color: Colors.white)),
                                    hintText: 'Email Address',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: th.kbluish,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  validator: (val) => val!.length < 6 ? 'Password must be 6 characters or more' : null,
                                  onChanged: (val) {
                                    setState(() => _password = val);
                                  },
                              cursorColor: th.kbluish,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        BorderSide(color: th.klemon)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                        const BorderSide(color: Colors.white)),
                                    hintText: 'Enter Your Password',
                                    prefixIcon: Icon(
                                      Icons.vpn_key_rounded,
                                      color: th.kbluish,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: th.kbluish,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: th.klemon)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide:
                                          const BorderSide(color: Colors.white)),
                                      hintText: 'Distributor/Vendor',
                                      prefixIcon: Icon(
                                        Icons.supervised_user_circle,
                                        color: th.kbluish,
                                      ),
                                    ),
                                    items: _userRoles.map((String role) {
                                      return DropdownMenuItem(
                                          value: role,
                                          child: Text(role)
                                      );
                                    }).toList(),
                                    onChanged: (val) => _userRole),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF3f3d56),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: TextButton(
                                          onPressed: () {
                                            if(_formKey.currentState!.validate()) {
                                              dynamic result = _auth.register(_userName, _email, _password, _userRole);
                                            }
                                            else {
                                              setState(() => _error = "Enter a valid email or password");
                                              log(_error.toString());
                                            }
                                          },
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: th.kwhite,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: th.kbluish,
                                    ),
                                  ),
                                  const Text("  or  "),
                                  Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: th.kbluish,
                                      )),
                                ]),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: th.klemon,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: TextButton(
                                        onPressed: widget.toggleView,
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: th.kblack,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}