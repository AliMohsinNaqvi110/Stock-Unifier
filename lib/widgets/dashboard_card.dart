import 'package:flutter/material.dart';
import 'package:inventory_management/constants/colors.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({
    required this.value,
    required this.color,
    Key? key,
    required this.text,
  }) : super(key: key);
  final String value;
  final String text;
  final Color color;

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  Apptheme th = Apptheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: widget.color
          /*boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3.0),
              blurRadius: 2,
              spreadRadius: 2,
              color: Colors.grey,
            ),
          ],*/
          /*gradient: LinearGradient(
            colors: widget.colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )*/
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.value,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: th.kWhite)),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: th.kWhite,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
