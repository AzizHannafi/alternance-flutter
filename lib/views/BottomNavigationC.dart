import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Simple Bottom Navigation')),
        body: Center(
          // width: ,
          child: Container(
            //color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Selected Page: ${_navBarItems[_selectedIndex].label}"),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: ColorsUtils.primaryGreen,
            currentIndex: _selectedIndex,
            selectedItemColor: ColorsUtils.primaryGreen,
            unselectedItemColor: ColorsUtils.primaryBleu,
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: _navBarItems,
          ),
        ));
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.business_center_outlined),
    activeIcon: Icon(Icons.business_center_outlined),
    label: 'Offers',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Saved',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications_active_outlined),
    activeIcon: Icon(Icons.notifications_active_outlined),
    label: 'News',
  ),
];
