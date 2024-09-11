import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawerc extends StatefulWidget {
  final Function(int) onItemTapped;

  const Drawerc({super.key, required this.onItemTapped});

  @override
  _DrawercState createState() => _DrawercState();
}

class _DrawercState extends State<Drawerc> {
  String _email = '';
  String _uername = '';
  int? _selectedIndex; // Track selected index

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? 'No email found';
      _uername = prefs.getString('userName') ?? 'No userName found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: constraints.maxHeight / 4,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  color: ColorsUtils.transparentGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorsUtils.primaryWhite,
                          border: Border.all(
                            color: ColorsUtils.primaryBleu,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            "images/hr_female.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _uername,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _email,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 0),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildListTile(
                      index: 0,
                      title: 'Account',
                      icon: Icons.person,
                      selectedIcon: Icons.person_2_outlined,
                    ),
                    _buildListTile(
                      index: 1,
                      title: 'Settings',
                      icon: Icons.settings,
                      selectedIcon: Icons.settings,
                    ),
                    _buildListTile(
                      index: 2,
                      title: 'Help',
                      icon: Icons.help,
                      selectedIcon: Icons.help,
                    ),
                    _buildListTile(
                      index: 3,
                      title: 'Logout',
                      icon: Icons.logout,
                      selectedIcon: Icons.logout,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTile({
    required int index,
    required String title,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 4), // Adjust vertical margin for spacing between items
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? ColorsUtils.transparentGreen
            : Colors.transparent, // Apply background color based on selection
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          widget.onItemTapped(index);
        },
        leading: Icon(
          _selectedIndex == index ? selectedIcon : icon,
        ),
        title: Text(title),
      ),
    );
  }
}
