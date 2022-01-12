import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/home/edit_items.dart';
import 'package:inventory_management/Screens/home/item_tile.dart';
import 'package:inventory_management/appTheme.dart';
class SelectedCategory extends StatefulWidget {

  SelectedCategory(this._selectedCategory, {Key? key}) : super(key: key);
  String _selectedCategory;

  @override
  _SelectedCategoryState createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {

  AppTheme th = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Category"),
        centerTitle: true,
        actions: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                  Icons.edit
              ),
            ),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Edit_Items(widget._selectedCategory)),
              );
            },
          )]
      ),
      body: Stack(
        children: [
          ItemTile(widget._selectedCategory),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: th.darkBlue,
                boxShadow: [
                  BoxShadow(
                    offset: ( Offset.fromDirection(1.0) ),
                    blurRadius: 10,
                    color: th.lightGrey,
                    spreadRadius: 10,
                  )
                ]
              ),
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
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                    TextSpan(
                                      text: "780",
                                      style: TextStyle(
                                        color: th.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      )
                                    )
                                ]
                              ),
                            ),
                        Text("Items Selected: 358 pcs",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: th.lightYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Add to cart", style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
