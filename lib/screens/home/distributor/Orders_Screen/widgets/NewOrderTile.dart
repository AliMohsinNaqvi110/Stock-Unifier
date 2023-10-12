import 'package:flutter/material.dart';

class NewOrderTile extends StatefulWidget {
  const NewOrderTile({Key? key}) : super(key: key);

  @override
  State<NewOrderTile> createState() => _NewOrderTileState();
}

class _NewOrderTileState extends State<NewOrderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey,
              foregroundImage: NetworkImage("https://icons.veryicon.com/png/o/internet--web/web-interface-flat/6606-male-user.png"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          "Order ID",
                        style: TextStyle(
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text("001")
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Items",
                            style: TextStyle(
                              fontWeight: FontWeight.w700
                              ),
                            ),
                            Text("Total Cost",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 4.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("550"),
                            Text("Rs. 250,000")
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
