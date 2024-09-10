import 'package:flutter/material.dart';
import 'Account.dart';
import 'Settings.dart';
import 'Help.dart';
import 'package:alternance_flutter/views/custom/BottomNavigationC.dart';
import 'package:alternance_flutter/views/Home.dart';
import 'package:alternance_flutter/views/News.dart';
import 'package:alternance_flutter/views/Offer.dart';
import 'package:alternance_flutter/views/Saved.dart';
import 'package:alternance_flutter/views/custom/DrawerC.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int _selectedIndex = 0;
  final List<Widget> bottomNavPages = const [Home(), Offer(), Saved(), News()];
  final List<Widget> drawerPages = const [Account(), Settings(), Help()];

  late Widget _currentBody = bottomNavPages[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _currentBody = bottomNavPages[_selectedIndex];
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentBody = bottomNavPages[index];
    });
  }

  void _onDrawerItemTapped(int index) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => drawerPages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alternance tn')),
      drawer: Drawerc(onItemTapped: _onDrawerItemTapped),
      body: _currentBody,
      bottomNavigationBar: BottomNavigationC(
        selectedIndex: _selectedIndex,
        onItemTapped: _onBottomNavItemTapped,
      ),
    );
  }
}
