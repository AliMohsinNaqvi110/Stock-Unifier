import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/support_files/list.dart';

class SalesHistory extends StatefulWidget {
  const SalesHistory({Key? key}) : super(key: key);


  @override
  _SalesHistoryState createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  List<Item> groceries = [
    Item(1, 'National Salt', 120, "assets/salt.jpeg", '12 dec 2021'),
    Item(2, 'Slice Juice', 30, "assets/slice.png", '12 dec 2021'),
    Item(1, 'National Salt', 120, "assets/salt.jpeg", '12 dec 2021'),
    Item(2, 'Slice Juice', 30, "assets/slice.png", '12 dec 2021'),
    Item(1, 'National Salt', 120, "assets/salt.jpeg", '12 dec 2021'),
    Item(2, 'Slice Juice', 30, "assets/slice.png", '12 dec 2021'),
    Item(3, 'Honey Small Jar', 300, "assets/honey.jpg", '14 dec 2021'),
    Item(4, 'Soda 1.5L', 130, "assets/drink.png", '14 dec 2021'),
    Item(5, 'Water', 35, "assets/water.jpeg", '14 dec 2021'),
    Item(3, 'Honey Small Jar', 300, "assets/honey.jpg", '14 dec 2021'),
    Item(4, 'Soda 1.5L', 130, "assets/drink.png", '14 dec 2021'),
    Item(5, 'Water', 35, "assets/water.jpeg", '14 dec 2021'),
    Item(3, 'Honey Small Jar', 300, "assets/honey.jpg", '14 dec 2021'),
    Item(4, 'Soda 1.5L', 130, "assets/drink.png", '14 dec 2021'),
    Item(5, 'Water', 35, "assets/water.jpeg", '14 dec 2021'),
    Item(6, 'Green Tea', 260, "assets/tea.png", '15 dec 2021'),
    Item(7, 'Coffee', 189, "assets/coffee.jpg", '15 dec 2021'),
    Item(6, 'Green Tea', 260, "assets/tea.png", '15 dec 2021'),
    Item(7, 'Coffee', 189, "assets/coffee.jpg", '15 dec 2021'),
    Item(6, 'Green Tea', 260, "assets/tea.png", '15 dec 2021'),
    Item(7, 'Coffee', 189, "assets/coffee.jpg", '15 dec 2021'),
  ];

  bool isEven = false;
  Apptheme th = Apptheme();
  @override

    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              title: const Text(
              "history",

              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: th.kWhite,
                  ),
                )
              ],
              // flexibleSpace: Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //       colors: [th.klemon, th.kyellow],
              //     ),
              //   ),
              // ),
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: th.kDarkBlue,
              centerTitle: true),
          body: ListView.builder(
            itemCount: groceries.length,
            itemBuilder: (context, index) {
              // if (index % 2 == 0) {
              //   isEven = true;
              // } else {
              //   isEven = false;
              // }
              String lastDate = index == 0
                  ? groceries[index].date
                  : groceries[index - 1].date;

              if (index == 0 || groceries[index].date != lastDate) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  ListTile(
                    title: Center(
                        child: Text(groceries[index].date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                fontSize: 16))),
                    tileColor: Colors.grey.shade300,
                  ),
                  historyTile(index),
                ]);
              } else {
                return historyTile(index);
              }
            },
          ));
    }

    ListTile historyTile(int index) {
      return ListTile(
        trailing: Stack(alignment: AlignmentDirectional.centerStart, children: [
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Text(
                  groceries[index].itemnum.toString() + ' pcs',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            width: 130,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            left: 3,
            child: Container(
              child: Center(
                child: Text(
                  'Rs. ' + groceries[index].itemprice.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              width: 80,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: th.kWhite,
              ),
            ),
          )
        ]),
        tileColor: index % 2 == 0 ? Colors.white : Colors.grey.shade200,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
          child: Text(
            groceries[index].itemname,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        subtitle: Text(groceries[index].date),
        // subtitle: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text("Item No : " + widget.items[index].itemprice.toString()),
        //     Text("Price : " +
        //         widget.items[index].itemnum.toString() +
        //         " Rs."),
        //   ],
        // ),
      );
    }
}