import 'package:flutter/material.dart';

class ChoreScreen extends StatelessWidget {
  ChoreScreen({super.key});

  final List<String> _names = ["Skip", "Rutger", "Karel", "Arthur", "Luc"];

  // Gets current + n weeks ahead
  String getFutureWeek(int n) {
    DateTime now = DateTime.now();
    int daysToEndOfWeek = ((8 - (7 - now.weekday)) % 7);
    now = now.add(Duration(days: daysToEndOfWeek));
    now = now.add(Duration(days: (n * 7)));
    return now.toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RuysChores"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Table(
          border: TableBorder.all(),
          children: <TableRow>[
            // Index
            TableRow(children: [
              Container(),
              Container(
                child: Text("This week"),
              ),
              Container(
                child: Text("Next week"),
              ),
              Container(
                child: Text(getFutureWeek(2)),
              ),
              Container(
                child: Text(getFutureWeek(3)),
              ),
            ]),
            for (final name in _names)
              TableRow(children: [
                Container(
                  child: Text(name),
                ),
                Container(),
                Container(),
                Container(),
                Container(),
              ]),
          ],
        ),
      ),
    );
  }
}
