import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({
    required this.value,
    required this.colors,
    Key? key,
    required this.text,
  }) : super(key: key);
  final String value;
  final String text;
  final List<Color> colors;

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3.0),
              blurRadius: 2,
              spreadRadius: 2,
              color: Colors.grey,
            ),
          ],
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: widget.colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}
