import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/home/distributor/edit_items.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/models/items.dart';
import 'package:provider/provider.dart';

import '../../widgets/item_tile.dart';

class SelectedCategory extends StatefulWidget {
  const SelectedCategory(this._selectedCategory, {Key? key}) : super(key: key);
  final String _selectedCategory;

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<Items>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: th.kDarkBlue,
          title: Text("Selected Category"),
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
                          Edit_Items(widget._selectedCategory)),
                );
              },
            )
          ]),
      body: Stack(
        children: [
          ItemTile(widget._selectedCategory),
          Positioned(
            bottom: 0,
            child: Consumer(
              builder: (BuildContext context, value, Widget? child) {
                return Container(
                  decoration: BoxDecoration(color: th.kDarkBlue, boxShadow: [
                    BoxShadow(
                        offset: (Offset.fromDirection(1.0)),
                        blurRadius: 10,
                        color: th.kLightGrey,
                        spreadRadius: 10)
                  ]),
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Rs: ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: _items.price.toString(),
                                        style: TextStyle(
                                            color: th.kYellow,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))
                                  ]),
                            ),
                            const Text(
                              "Items Selected: 358 pcs",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: th.kLemon,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            "Add to cart",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
