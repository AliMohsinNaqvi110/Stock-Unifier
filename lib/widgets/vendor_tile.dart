import 'package:flutter/material.dart';

class VendorTile extends StatefulWidget {
  final String name;
  final String balance;
  final String dues;
  const VendorTile({Key? key, required this.name, required this.balance, required this.dues}) : super(key: key);

  @override
  State<VendorTile> createState() => _VendorTileState();
}

class _VendorTileState extends State<VendorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade800, width: 1))),
      child: ListTile(
        title: Text(
          widget.name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5),
        ),
        leading: const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
              "https://icon-library.com/images/user-png-icon/user-png-icon-6.jpg"),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Balance : ${widget.balance}",
              style: const TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 4,),
            Text(
              "Dues : ${widget.dues}",
              style: const TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
