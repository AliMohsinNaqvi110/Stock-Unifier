import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/authentication/forgetpass.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/services/auth.dart';


class Login extends StatefulWidget {
  final void Function() toggleView;
  // ignore: use_key_in_widget_constructors
  const Login(this.toggleView);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  Apptheme th = Apptheme();
  bool _showPassword = false;
  String _email = "";
  String _password = "";
  String _error = "";


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
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "Log In To Your Acount",
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
                    image: AssetImage("assets/login_illustration.png"),
                    width: 240,
                    height: 220,
                  ),
                  SizedBox(
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
                                  cursorColor: th.kbluish,
                                  decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        new BorderSide(color: th.klemon)),
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                        new BorderSide(color: Colors.white)),
                                    hintText: 'Email Address',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: th.kbluish,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  validator: (val) => val!.length< 6 ? 'Password must be 6 characters or more' : null,
                                  onChanged: (val) {
                                    setState(() => _password = val);
                                  },
                                  cursorColor: th.kbluish,
                                  obscureText: _showPassword,
                                  decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                        new BorderSide(color: th.klemon)),
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide:
                                        new BorderSide(color: Colors.white)),
                                    hintText: 'Enter Your Password',
                                    prefixIcon: Icon(
                                      Icons.vpn_key_rounded,
                                      color: th.kbluish,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: th.kbluish,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                                  builder: (context) => const forgetpass()));
                                        },
                                        child: Text("Forgot Password",
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
                                        onPressed: () {
                                          if(_formKey.currentState!.validate()) {
                                            dynamic result = _auth.signInWithEmailAndPassword(_email, _password);
                                            setState(() => _error = "Enter a valid email or password");
                                          }
                                        },
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: th.kwhite,
                                              fontWeight: FontWeight.bold),
                                        ))),
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
                                          "Sign up",
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