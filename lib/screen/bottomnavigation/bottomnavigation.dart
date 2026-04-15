import 'package:flutter/material.dart';
import 'package:investorapp/screen/deal/deallisted/deallisted.dart';
import 'package:investorapp/screen/deal/dealinterest/dealinterested.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const Deallisted(),
    const InterestedList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: "Deals",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Interested",
          ),
        ],
      ),
    );
  }
}