import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  padding: const EdgeInsets.all(30),
                  // color: ColorsUtils.primaryGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorsUtils.transparentGreen,
                          border: Border.all(
                            color: ColorsUtils.primaryBleu,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: ClipRRect(
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
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsUtils.transparentGreen),
                child: ListTile(
                  title: const Text("Account"),
                  leading: const Icon(Icons.person),
                  onTap: () => onItemTapped(0),
                ),
              ),
              ListTile(
                focusColor: ColorsUtils.lightGray,
                title: const Text("Settings"),
                leading: const Icon(Icons.settings),
                onTap: () => onItemTapped(1),
              ),
              ListTile(
                focusColor: ColorsUtils.lightGray,
                title: const Text("Help"),
                leading: const Icon(Icons.help),
                onTap: () => onItemTapped(2),
              ),
              const ListTile(
                focusColor: ColorsUtils.lightGray,
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
