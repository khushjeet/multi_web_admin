import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  static const String routeName = "/DashboardPage";

  const DashBoardPage({super.key});

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), color: Colors.grey),
        child: Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              "MANAGE DASHBOARD",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
            ),
          ),
          Row(
            children: [
              _rowHeader("IMAGE", 1),
              _rowHeader("FULL NAME", 1),
              _rowHeader("CITY", 1),
              _rowHeader("STATE", 1),
              _rowHeader("ACTION", 1),
              _rowHeader("VIEW MORE", 1),
            ],
          )
        ],
      ),
    );
  }
}
