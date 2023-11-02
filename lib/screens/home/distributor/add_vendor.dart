import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/constants/text_decoration.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddVendor extends StatefulWidget {
  const AddVendor({Key? key}) : super(key: key);

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  Apptheme th = Apptheme();
  late dynamic _db;
  final _formKey = GlobalKey<FormState>();
  Uuid uuid = const Uuid();

  // Text Controllers
  TextEditingController vendorNameTextController = TextEditingController();
  TextEditingController vendorUidTextController = TextEditingController();
  TextEditingController vendorBalanceTextController = TextEditingController();
  TextEditingController vendorDuesTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _db = DatabaseService(Provider.of<User>(context, listen: false).uid);
    vendorUidTextController.text = uuid.v4();
    log(vendorUidTextController.text);
  }

  @override
  void dispose() {
    super.dispose();
    vendorNameTextController.dispose();
    vendorBalanceTextController.dispose();
    vendorDuesTextController.dispose();
    vendorUidTextController.dispose();
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
                            "Vendor ID",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: vendorUidTextController,
                          decoration: textInputDecoration.copyWith(
                              suffixIcon: InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: vendorUidTextController.text));
                                    if (!mounted) {
                                      return;
                                    }
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Copied Successfully")));
                                  },
                                  child: const Icon(Icons.copy))),
                        ),
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
                              balance:
                                  int.parse(vendorBalanceTextController.text),
                              dues: int.parse(vendorDuesTextController.text),
                              vendorId: vendorUidTextController.text
                              //   TODO Add Vendor ID
                              );
                          CoolAlert.show(
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                              },
                              context: context,
                              type: CoolAlertType.success,
                              title: "Success",
                              text: "Send this id to this vendor!",
                              widget: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Copy and send these values to the vendor",
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                    const SizedBox(height: 12.0),
                                    const Text("Your UID"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(user.uid.toString(),
                                            style: const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 10),
                                        InkWell(
                                            onTap: () async {
                                              await Clipboard.setData(ClipboardData(
                                                  text: user.uid.toString()));
                                              if (!mounted) {
                                                return;
                                              }
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Copied Successfully")));
                                            },
                                            child: const Icon(Icons.copy))
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    const Text("Vendor's UID"),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(vendorUidTextController.text,
                                            style: const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 10),
                                        InkWell(
                                            onTap: () async {
                                              await Clipboard.setData(ClipboardData(
                                                  text: vendorUidTextController.text));
                                              if (!mounted) {
                                                return;
                                              }
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Copied Successfully")));
                                            },
                                            child: const Icon(Icons.copy))
                                      ],
                                    ),

                                  ],
                                ),
                              ));
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
