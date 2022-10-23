import 'package:beer_tally/widget/tally_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer tally',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bier met de bitches'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 11,
                  )),
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 1,
                  )),
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 3,
                  )),
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 40,
                  )),
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 60,
                  )),
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 60,
                  )),
              SizedBox(
                  height: 100,
                  child: TallyRow(
                    totalBeers: 60,
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("floating"),
        child: Text("Refill"),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.abc_rounded), label: "temp"),
        BottomNavigationBarItem(icon: Icon(Icons.abc_rounded), label: "temp"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ]),
    );
  }
}
