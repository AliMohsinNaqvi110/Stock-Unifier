import 'package:flutter/material.dart';
import 'package:inventory_management/Screens/home/selected_category.dart';
import 'package:inventory_management/services/auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  AuthService _auth = AuthService();
  final List<String> _selectedCategory = [
    "Groceries", "Confectionary", "Snacks", "Beverages", "Health care", "Cosmetics"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[0])),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width / 1.25,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo,
                          Colors.indigo.withOpacity(0.6),
                          Colors.blueGrey
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.indigo[600],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                          child: Image(
                            height: 80,
                            width: 80,
                            image: AssetImage("assets/groceries.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Center(child: Text(
                            "Groceries",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        )),
                      ],
                    )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[1])),
                      );
                    },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo,
                            Colors.indigo.withOpacity(0.6),
                            Colors.blueGrey
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.indigo[600],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                            child: Image(
                              height: 80,
                              width: 80,
                              image: AssetImage("assets/confectionary.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(child: Text(
                            "Confectionary",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[2])),
                      );
                    },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo,
                            Colors.indigo.withOpacity(0.6),
                            Colors.blueGrey
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.indigo[600],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                            child: Image(
                              height: 80,
                              width: 80,
                              image: AssetImage("assets/snacks.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(child: Text(
                            "Snacks",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[3])),
                      );
                    },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo,
                            Colors.indigo.withOpacity(0.6),
                            Colors.blueGrey
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.indigo[600],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                            child: Image(
                              height: 80,
                              width: 80,
                              image: AssetImage("assets/beverages.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(child: Text(
                            "Beverages",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[4])),
                    );
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo,
                            Colors.indigo.withOpacity(0.6),
                            Colors.blueGrey
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.indigo[600],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                            child: Image(
                              height: 80,
                              width: 80,
                              image: AssetImage("assets/medicine.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(child: Text(
                            "Health Care",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedCategory(_selectedCategory[5])),
                    );
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo,
                            Colors.indigo.withOpacity(0.6),
                            Colors.blueGrey
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.indigo[600],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                            child: Image(
                              height: 80,
                              width: 80,
                              image: AssetImage("assets/cosmetics(1).png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(child: Text(
                            "Cosmetics",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
