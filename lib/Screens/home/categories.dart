import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/home/selected_category.dart';
import 'package:inventory_management/constants/colors.dart';
import 'package:inventory_management/services/auth.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  Apptheme th = Apptheme();
  AuthService _auth = AuthService();
  final List<String> _selectedCategory = [
    "Groceries", "Confectionary", "Snacks", "Beverages", "Medicine", "Cosmetics"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: th.klight_grey,
      appBar: AppBar(
        backgroundColor: th.kbluish,
        title: Text(
          "Dashboard"
        ),
          actions: [
            InkWell(
              child: Icon(
                  Icons.exit_to_app
              ),
              onTap:  () {
                _auth.signOut();
              },
            )]
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[0])),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: th.kwhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.0,
                              spreadRadius: 2.0,
                              offset: Offset(0, 6)
                            )
                          ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.92,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Groceries",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "Items Available: 50",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: -10,
                      child: Image(
                        fit: BoxFit.contain,
                        height: 100,
                        width: 220,
                        image: AssetImage("assets/groceries.png",),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[1])),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: th.kwhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 6)
                              )
                            ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Confectionary",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "Items Available: 50",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: -10,
                      child: Image(
                        fit: BoxFit.contain,
                        height: 100,
                        width: 220,
                        image: AssetImage("assets/confectionaries.png",),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[2])),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: th.kwhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 6)
                              )
                            ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Snacks",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "Items Available: 50",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: -10,
                      child: Image(
                        fit: BoxFit.contain,
                        height: 100,
                        width: 220,
                        image: AssetImage("assets/snacks.png",),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[3])),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: th.kwhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 6)
                              )
                            ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Beverages",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "Items Available: 50",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: -10,
                      child: Image(
                        fit: BoxFit.contain,
                        height: 100,
                        width: 220,
                        image: AssetImage("assets/beverages.png",),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[4])),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: th.kwhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 6)
                              )
                            ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Medicine",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "Items Available: 50",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: -10,
                      child: Image(
                        fit: BoxFit.contain,
                        height: 100,
                        width: 220,
                        image: AssetImage("assets/medicine.png",),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[5])),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: th.kwhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 6)
                              )
                            ]
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cosmetics",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  "Items Available: 50",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: -10,
                      child: Image(
                        fit: BoxFit.contain,
                        height: 100,
                        width: 220,
                        image: AssetImage("assets/cosmetics.png",),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
