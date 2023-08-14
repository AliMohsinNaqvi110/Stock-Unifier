import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/constants/text_decoration.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';

class AddVendor extends StatefulWidget {
  const AddVendor({Key? key}) : super(key: key);

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  Apptheme th = Apptheme();
  final AuthService _auth = AuthService();
  late dynamic _db;
  final _formKey = GlobalKey<FormState>();
  // Text Controllers
  TextEditingController vendorNameTextController = TextEditingController();
  TextEditingController vendorBalanceTextController = TextEditingController();
  TextEditingController vendorDuesTextController = TextEditingController();
  TextEditingController vendorMobileNumberTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _db = DatabaseService(Provider.of<User>(context, listen: false).uid);
    vendorBalanceTextController.text = "0";
    vendorDuesTextController.text = "0";
  }

  @override
  void dispose() {
    super.dispose();
    vendorNameTextController.dispose();
    vendorBalanceTextController.dispose();
    vendorDuesTextController.dispose();
    vendorMobileNumberTextController.dispose();
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
                            "Mobile Number",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: vendorMobileNumberTextController,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Vendor Mobile Number")),
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
                          _db.createVendor(
                            vendorName: vendorNameTextController.text,
                            balance: int.parse(vendorBalanceTextController.text),
                            dues: int.parse(vendorDuesTextController.text)
                          );
                          CoolAlert.show(
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                            },
                            context: context,
                            type: CoolAlertType.success,
                            title: "Success",
                            text: "Send this id to this vendor!",
                          );
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
