import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/screens/home/distributor/add_items.dart';
import 'package:inventory_management/screens/home/selected_category.dart';
import 'package:inventory_management/services/database.dart';
import 'package:provider/provider.dart';

class ManageInventory extends StatefulWidget {
  const ManageInventory({Key? key}) : super(key: key);

  @override
  State<ManageInventory> createState() => _ManageInventoryState();
}

class _ManageInventoryState extends State<ManageInventory> {
  final List<String> _selectedCategory = [
    "Groceries",
    "Confectionary",
    "Snacks",
    "Beverages",
    "Medicine",
    "Cosmetics"
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Apptheme th = Apptheme();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: th.kDarkBlue,
          title: const Text("Manage Inventory"),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddItems()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: th.kWhite,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 6))
                              ]),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 30),
                            child: Text(
                              "Add Items",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 30,
                        right: -10,
                        child: Image(
                          fit: BoxFit.contain,
                          height: 100,
                          width: 220,
                          image: AssetImage(
                            "assets/add_to_inventory_illustration.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<int>(
                  future: DatabaseService(user.uid)
                      .getCategoryItemCount("Groceries"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[0])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.92,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Groceries",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: 0",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/groceries.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      int itemCount = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[0])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.92,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Groceries",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: $itemCount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/groceries.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: DatabaseService(user.uid)
                      .getCategoryItemCount("Confectionary"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[1])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Confectionary",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: 0",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/confectionaries.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      int itemCount = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[1])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Confectionary",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: $itemCount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/confectionaries.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
                FutureBuilder<int>(
                  future:
                      DatabaseService(user.uid).getCategoryItemCount("Snacks"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[2])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Snacks",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: 0",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/snacks.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      int itemCount = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[2])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Snacks",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: $itemCount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/snacks.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: DatabaseService(user.uid)
                      .getCategoryItemCount("Beverages"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[3])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Beverages",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: 0",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/beverages.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      int itemCount = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[3])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Beverages",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: $itemCount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/beverages.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: DatabaseService(user.uid)
                      .getCategoryItemCount("Medicine"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[4])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Medicine",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: 0",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/medicine.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      int itemCount = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[4])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Medicine",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: $itemCount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/medicine.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: DatabaseService(user.uid)
                      .getCategoryItemCount("Cosmetics"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[5])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Cosmetics",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: 0",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/cosmetics.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      int itemCount = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          //overflow: Overflow.visible,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategory(
                                          selectedCategory:
                                              _selectedCategory[5])),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 6))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Cosmetics",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Items Available: $itemCount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 30,
                              right: -10,
                              child: Image(
                                fit: BoxFit.contain,
                                height: 100,
                                width: 220,
                                image: AssetImage(
                                  "assets/cosmetics.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
                Container(
                  height: 80,
                )
              ],
            ),
          ),
        ));
  }
}
