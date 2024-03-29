import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:provider/provider.dart';

class EditItems extends StatefulWidget {
  final String selectedCategory;

  const EditItems({required this.selectedCategory, Key? key}) : super(key: key);

  @override
  _EditItemsState createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  Apptheme th = Apptheme();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: th.kDarkBlue,
        title: Text("${widget.selectedCategory} List"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("inventory")
            .doc(user.uid)
            .collection("items")
            .where("category", isEqualTo: widget.selectedCategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No Items yet"));
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot _items = snapshot.data!.docs[index];
                  return ExpansionTile(
                    title: Text(_items["Item_Name"]),
                    collapsedBackgroundColor:
                        index % 2 == 0 ? th.kWhite : th.kLightGrey,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Price: "),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.60,
                              decoration: BoxDecoration(
                                  color: th.kYellow,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: const Icon(Icons.remove),
                                    onTap: () {
                                      if (_items["Price"] == 0) {
                                        return;
                                      } else {
                                        setState(() {
                                          _items["Price"];
                                        });
                                      }
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                        color: th.kWhite,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: priceController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(top: 8.0),
                                        hintText: _items["Price"].toString(),
                                        //_items["Price"].toString(),
                                        border: const OutlineInputBorder(),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          //_items["Price"] = int.parse(val);
                                        });
                                      },
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          //_items["Price"];
                                        });
                                      },
                                      child: const Icon(Icons.add)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Quantity: "),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.60,
                            decoration: BoxDecoration(
                                color: th.kYellow,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: const Icon(Icons.remove),
                                  onTap: () {
                                    if (_items["Quantity"] == 0) {
                                      return;
                                    } else {
                                      setState(() {
                                        // _items["Price"];
                                      });
                                    }
                                  },
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      color: th.kWhite,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(top: 8.0),
                                      hintText: _items["Quantity"].toString(),
                                      border: const OutlineInputBorder(),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        //_price = int.parse(val);
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        // _items["Price"]++;
                                      });
                                    },
                                    child: const Icon(Icons.add)),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
