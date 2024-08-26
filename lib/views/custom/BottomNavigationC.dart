import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class BottomNavigationC extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationC({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ColorsUtils.primaryGreen,
      currentIndex: selectedIndex,
      selectedItemColor: ColorsUtils.primaryGreen,
      unselectedItemColor: ColorsUtils.primaryBleu,
      type: BottomNavigationBarType.shifting,
      onTap: onItemTapped,
      items: _navBarItems,
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.business_center_outlined),
    activeIcon: Icon(Icons.business_center),
    label: 'Offers',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Saved',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications_active_outlined),
    activeIcon: Icon(Icons.notifications),
    label: 'News',
  ),
];
