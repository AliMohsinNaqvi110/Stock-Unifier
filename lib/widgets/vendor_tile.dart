import 'package:flutter/material.dart';

class VendorTile extends StatefulWidget {
  const VendorTile({Key? key}) : super(key: key);

  @override
  State<VendorTile> createState() => _VendorTileState();
}

class _VendorTileState extends State<VendorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade800, width: 1))
      ),
      child: ListTile(
        title: Text("Vendor Name"),
        leading: Image.network(
            "https://cdn2.iconfinder.com/data/icons/flat-style-svg-icons-part-1/512/user_man_male_profile_account-512.png"),
      ),
    );
  }
}
