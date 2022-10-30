import 'package:beer_tally/screens/beer_tally_screen.dart';
import 'package:beer_tally/screens/chores_screen.dart';
import 'package:beer_tally/screens/settings_modal.dart';
import 'package:beer_tally/screens/who_home_screen.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Routing
  int _currentIndex = 1;
  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static final List<Widget> _screens = [
    const WhoHomeScreen(),
    BeerTallyScreen(),
    ChoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.blue.shade300,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Who be home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_bar),
            label: "Beer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services),
            label: "Chores",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: setIndex,
      ),
    );
  }
}
