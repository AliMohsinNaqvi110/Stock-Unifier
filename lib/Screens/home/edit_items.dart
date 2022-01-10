import 'package:flutter/material.dart';

class Edit_Items extends StatefulWidget {

  Edit_Items(this._selectedCategory);
  String _selectedCategory;

  @override
  _Edit_ItemsState createState() => _Edit_ItemsState();
}

class _Edit_ItemsState extends State<Edit_Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit " + widget._selectedCategory.toString() + " List"),
        centerTitle: true,
      ),
    );
  }
}
