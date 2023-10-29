import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/screens/home/distributor/edit_items.dart';
import '../../widgets/item_tile.dart';

class SelectedCategory extends StatefulWidget {
  final String selectedCategory;

  const SelectedCategory({required this.selectedCategory, Key? key})
      : super(key: key);

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: th.kDarkBlue,
          title: const Text("Selected Category"),
          centerTitle: true,
          actions: [
            InkWell(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.edit),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditItems(selectedCategory: widget.selectedCategory)),
                );
              },
            )
          ]),
      body: ItemTile(widget.selectedCategory),
    );
  }
}
