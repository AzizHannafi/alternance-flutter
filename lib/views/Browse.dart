import 'package:alternance_flutter/utils/SharedPreferencesUtils.dart';
import 'package:alternance_flutter/views/Help.dart';
import 'package:alternance_flutter/views/Home.dart';
import 'package:alternance_flutter/views/News.dart';
import 'package:alternance_flutter/views/Offer.dart';
import 'package:alternance_flutter/views/Profile.dart';
import 'package:alternance_flutter/views/Saved.dart';
import 'package:alternance_flutter/views/Settings.dart';
import 'package:alternance_flutter/views/custom/BottomNavigationC.dart';
import 'package:alternance_flutter/views/custom/DrawerC.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int _userId = 0;
  int _selectedIndex = 0;

  final List<Widget> bottomNavPages = const [Home(), Offer(), Saved(), News()];
  late Widget _currentBody = bottomNavPages[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    // Await for SharedPreferences initialization
    await SharedPreferencesUtils.init();
    // Load the user ID after the preferences are initialized
    setState(() {
      _userId = SharedPreferencesUtils.getValue<int>("id") ?? 0;
      _currentBody =
          bottomNavPages[_selectedIndex]; // Ensure body is set after init
    });
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
      MaterialPageRoute(
        builder: (context) {
          final List<Widget> drawerPages = [
            Profile(userId: _userId),
            const Settings(),
            const Help()
          ];
          return drawerPages[index];
        },
      ),
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
