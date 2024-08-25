import 'package:alternance_flutter/views/BottomNavigationC.dart';
import 'package:alternance_flutter/views/Home.dart';
import 'package:alternance_flutter/views/News.dart';
import 'package:alternance_flutter/views/Offer.dart';
import 'package:alternance_flutter/views/Saved.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int _selectedIndex = 0;
  final List<Widget> pages = const [Home(), Offer(), Saved(), News()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alternance tn')),
      body: pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationC(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
