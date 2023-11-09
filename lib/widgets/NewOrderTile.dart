import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/constants/text_decoration.dart';
import 'package:inventory_management/models/orders.dart';
import 'package:inventory_management/services/database.dart';
import 'package:inventory_management/widgets/OrderItemTile.dart';
import 'package:inventory_management/widgets/item_tile.dart';
import 'package:provider/provider.dart';

class NewOrderTile extends StatefulWidget {
  final Orders order;

  const NewOrderTile({Key? key, required this.order}) : super(key: key);

  @override
  State<NewOrderTile> createState() => _NewOrderTileState();
}

class _NewOrderTileState extends State<NewOrderTile> {
  Apptheme th = Apptheme();
  bool reject = false;
  bool showDetails = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController reasonTextController = TextEditingController();

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
            Visibility(
              visible: !reject,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        bool result = await DatabaseService(user.uid)
                            .updateOrderStatus(
                                widget.order.orderId, "accepted");
                        if (result) {
                          if (!mounted) {
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order Accepted")));
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
                          "Accept",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          reject = true;
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
                          "Reject",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showDetails = !showDetails;
                      });
                    },
                    child: Text(
                      showDetails ? "Hide Details" : "Show Details",
                      style: TextStyle(
                          color: th.kDashboardCyan,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showDetails,
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.order.items.length,
                  itemBuilder: (context, index) => OrderItemTile(
                      itemName: widget.order.items[index].name,
                      quantity: widget.order.items[index].quantity,
                      price: widget.order.items[index].price,
                      itemId: widget.order.items[index].itemId,
                      category: widget.order.items[index].category)
                ),
              ),
            ),
            Visibility(
                visible: reject,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val!.isEmpty
                            ? "Please enter reason why you cancelled this order"
                            : null,
                        controller: reasonTextController,
                        decoration: textInputDecoration.copyWith(
                            label: const Text("Reason")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                bool result = await DatabaseService(user.uid)
                                    .updateOrderStatus(
                                        widget.order.orderId, "rejected");
                                if (result) {
                                  if (!mounted) {
                                    return;
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Order Accepted")));
                                }
                              },
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Center(
                                    child: Text(
                                  "Reject Order",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                )),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  reject = false;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                    color: th.kDarkBlue,
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
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
