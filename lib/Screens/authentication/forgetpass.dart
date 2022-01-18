import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({Key? key}) : super(key: key);

  @override
  _forgetpassState createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  @override
  Apptheme th = Apptheme();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: th.kbluish,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We have send an email,with a link to reset your password",
                    style: TextStyle(
                      color: th.kbluish.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Image(
                    image: AssetImage("assets/reset_password_illustration.png"),
                    width: 240,
                    height: 220,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFFF9A826),
                      ),
                      width: 350,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              cursorColor: th.kbluish,
                              obscureText: false,
                              decoration: new InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                                hintText: 'Email Address',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: th.kbluish,
                                ),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF3f3d56),
                                    borderRadius: BorderRadius.circular(10)),
                                child: FlatButton(
                                    onPressed: null,
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: th.kwhite,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}