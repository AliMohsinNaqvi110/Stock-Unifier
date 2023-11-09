import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/constants/text_decoration.dart';
import 'package:inventory_management/models/orders.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';

class AcceptedOrderTile extends StatefulWidget {
  final Orders order;

  const AcceptedOrderTile({Key? key, required this.order}) : super(key: key);

  @override
  State<AcceptedOrderTile> createState() => _AcceptedOrderTileState();
}

class _AcceptedOrderTileState extends State<AcceptedOrderTile> {
  Apptheme th = Apptheme();
  bool showTextFields = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountReceivedTextController = TextEditingController();
  TextEditingController duesTextController = TextEditingController();
  TextEditingController balanceTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent.withOpacity(0.2)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Vendor",
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.order.vendorName,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Order ID",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 8.0),
                          Text("# ${widget.order.orderId}"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Total Items",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Total Cost",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            const SizedBox(width: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.order.selectedItemCount.toString()),
                                Text("Rs. ${widget.order.totalPrice}")
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showTextFields = true;
                });
              },
              child: Visibility(
                visible: !showTextFields,
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        height: 45,
                        decoration: BoxDecoration(
                            color: th.kDarkBlue,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Center(
                            child: Text(
                          "Mark As Completed",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "View Details",
                    style: TextStyle(
                        color: th.kDashboardCyan,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Visibility(
                  visible: showTextFields,
                  child: Form(
                    key: _formKey,
                      child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val!.isEmpty ? "Please specify the amount received from vendor" : null,
                        onChanged: (val) {
                          if (val.isEmpty ||
                              int.parse(val) == widget.order.totalPrice) {
                            duesTextController.clear();
                            balanceTextController.clear();
                          }
                          if (int.parse(val) < widget.order.totalPrice) {
                            balanceTextController.clear();
                            int dues = widget.order.totalPrice - int.parse(val);
                            duesTextController.text = dues.toString();
                          } else {
                            duesTextController.clear();
                            int balance =
                                int.parse(val) - widget.order.totalPrice;
                            balanceTextController.text = balance.toString();
                          }
                        },
                        controller: amountReceivedTextController,
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(
                            label: const Text("Amount Received")),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: duesTextController,
                        readOnly: true,
                        decoration: textInputDecoration.copyWith(
                            label: const Text("Dues")),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: balanceTextController,
                        readOnly: true,
                        decoration: textInputDecoration.copyWith(
                            label: const Text("Balance")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if(_formKey.currentState!.validate()) {
                                  bool result = await DatabaseService(user.uid)
                                      .updateOrderStatus(
                                      widget.order.orderId, "completed");

                                  if (result) {
                                    amountReceivedTextController.clear();
                                    balanceTextController.clear();
                                    duesTextController.clear();
                                    if (!mounted) {
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Order Completed")));
                                  }
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
                                  "Complete",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                )),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showTextFields = false;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
