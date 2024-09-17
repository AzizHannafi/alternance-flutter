import 'package:alternance_flutter/utils/SharedPreferencesUtils.dart';
import 'package:alternance_flutter/views/Help.dart';
import 'package:alternance_flutter/views/Home.dart';
import 'package:alternance_flutter/views/News.dart';
import 'package:alternance_flutter/views/Offer.dart';
import 'package:alternance_flutter/views/Profile.dart';
import 'package:alternance_flutter/views/Application.dart';
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
  List<Widget> bottomNavPages = []; // Initialize with empty list
  Widget _currentBody =
      const Center(child: CircularProgressIndicator()); // Default placeholder

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
      bottomNavPages = [Home(userId: _userId), Offer(), Application(), News()];
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
      appBar: AppBar(
        flexibleSpace: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Image.asset(
              'images/alternance_logo.png',
              height: 30,
            ),
          ),
        ),
        elevation: 0, // Optional: remove shadow if needed
        backgroundColor:
            Colors.transparent, // Optional: make background transparent
      ),
      drawer: Drawerc(onItemTapped: _onDrawerItemTapped),
      body: _currentBody,
      bottomNavigationBar: BottomNavigationC(
        selectedIndex: _selectedIndex,
        onItemTapped: _onBottomNavItemTapped,
      ),
    );
  }
}
