import 'package:flutter/material.dart';
import 'package:the_catholic_faith/pages/home.dart';
import 'package:the_catholic_faith/pages/prayers.dart';
import 'package:the_catholic_faith/pages/menu.dart';

class Bar extends StatefulWidget {
  const Bar({super.key});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  var theme = 'Light';
  int currentIndex = 0;
  List<Widget> page = const [
    Home(),
    Prayers(),
    Menu(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Prayers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: page
      ),
    );
  }
}