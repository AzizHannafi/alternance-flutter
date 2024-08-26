import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class Drawerc extends StatelessWidget {
  final Function(int) onItemTapped;

  const Drawerc({super.key, required this.onItemTapped});

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
                  // color: ColorsUtils.primaryGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorsUtils.primaryGreen,
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
                      const Text(
                        "Aziz Hannafi",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "hannafimedaziz@gmail.com",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                title: const Text("Account"),
                leading: const Icon(Icons.person),
                onTap: () => onItemTapped(0),
              ),
              ListTile(
                title: const Text("Settings"),
                leading: const Icon(Icons.settings),
                onTap: () => onItemTapped(1),
              ),
              ListTile(
                title: const Text("Help"),
                leading: const Icon(Icons.help),
                onTap: () => onItemTapped(2),
              ),
              const ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                // onTap: () => onItemTapped(3),
              )
            ],
          );
        },
      ),
    );
  }
}
