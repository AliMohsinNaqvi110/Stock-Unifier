import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/services/auth.dart';

import 'forgetpass.dart';


class Login extends StatefulWidget {
  final void Function() toggleView;
  const Login(this.toggleView, {Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  Apptheme th = Apptheme();
  bool _hidePassword = true;
  String _email = "";
  String _password = "";
  dynamic _error;

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
                      "Log In To Your Acount",
                      style: TextStyle(
                          color: th.kDarkBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Image(
                    image: AssetImage("assets/login_illustration.png"),
                    width: 240,
                    height: 220,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFF9A826),
                          ),
                          width: 350,
                          height: 378,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                  cursorColor: th.kDarkBlue,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        BorderSide(color: th.kLemon)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                        const BorderSide(color: Colors.white)),
                                    hintText: 'Email Address',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: th.kDarkBlue,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  validator: (val) => val!.length< 6 ? 'Password must be 6 characters or more' : null,
                                  onChanged: (val) {
                                    setState(() => _password = val);
                                  },
                                  cursorColor: th.kDarkBlue,
                                  obscureText: _hidePassword,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        BorderSide(color: th.kLemon)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide:
                                        const BorderSide(color: Colors.white)),
                                    hintText: 'Enter Your Password',
                                    prefixIcon: Icon(
                                      Icons.vpn_key_rounded,
                                      color: th.kDarkBlue,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                      child: Icon(
                                        _hidePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: th.kDarkBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                                  builder: (context) => const forgetpass()));
                                        },
                                        child: const Text("Forgot Password",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF3f3d56),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: TextButton(
                                        onPressed: () async {
                                          if(_formKey.currentState!.validate()) {
                                            dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
                                            if(result.runtimeType == String) {
                                              setState(() => _error = result);
                                              if(!mounted) {return;}
                                              AnimatedSnackBar.material(
                                                _error,
                                                type: AnimatedSnackBarType.error,
                                                mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                                              ).show(context);
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: th.kWhite,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: th.kDarkBlue,
                                    ),
                                  ),
                                  const Text("  or  "),
                                  Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: th.kDarkBlue,
                                      )),
                                ]),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: th.kLemon,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: TextButton(
                                        onPressed: widget.toggleView,
                                        child: Text(
                                          "Sign up",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: th.kBlack,
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