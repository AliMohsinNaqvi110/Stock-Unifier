import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/constants/text_decoration.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:provider/provider.dart';

class AddVendor extends StatefulWidget {
  const AddVendor({Key? key}) : super(key: key);

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  Apptheme th = Apptheme();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  TextEditingController vendorNameTextController = TextEditingController();
  TextEditingController vendorEmailTextController = TextEditingController();
  TextEditingController vendorPasswordTextController = TextEditingController();
  TextEditingController vendorBalanceTextController = TextEditingController();
  TextEditingController vendorDuesTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vendorBalanceTextController.text = "0";
    vendorDuesTextController.text = "0";
  }

  @override
  void dispose() {
    super.dispose();
    vendorNameTextController.dispose();
    vendorEmailTextController.dispose();
    vendorPasswordTextController.dispose();
    vendorBalanceTextController.dispose();
    vendorDuesTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: th.kDarkBlue,
        title: const Text("Add Vendor"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            "Vendor Name",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                            controller: vendorNameTextController,
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Vendor name can't be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Vendor Name")),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                            controller: vendorEmailTextController,
                            validator: (String? val) {
                              if (val == null || !val.contains("@")) {
                                return "please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Vendor Email")),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                            controller: vendorPasswordTextController,
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Vendor password can't be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Vendor Password")),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            "Balance",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: vendorBalanceTextController,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Vendor Balance")),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            "Dues",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: vendorDuesTextController,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Vendor Dues")),
                      ],
                    ),
                  ),

                  // Button
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 80.0),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _auth.registerVendor(
                              vendorNameTextController.text,
                              vendorEmailTextController.text,
                              vendorPasswordTextController.text,
                              user.uid,
                              int.parse(vendorBalanceTextController.text),
                              int.parse(vendorDuesTextController.text));
                        }
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: th.kDarkBlue,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Center(
                            child: Text(
                          "Add Vendor",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
