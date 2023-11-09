import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/models/orders.dart';
import 'package:inventory_management/widgets/OrderItemTile.dart';

class CompletedOrderTile extends StatefulWidget {
  final Orders order;

  const CompletedOrderTile({Key? key, required this.order}) : super(key: key);

  @override
  State<CompletedOrderTile> createState() => _CompletedOrderTileState();
}

class _CompletedOrderTileState extends State<CompletedOrderTile> {
  Apptheme th = Apptheme();
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
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
                    physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}
