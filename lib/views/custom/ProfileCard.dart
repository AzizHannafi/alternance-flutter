import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Add rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center content
        children: [
          Stack(
            alignment: Alignment.center, // Center the profile image
            children: [
              // Background image
              Image.network(
                'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Profile image centered
              Positioned(
                bottom: 20,
                child: Container(
                  padding: EdgeInsets.all(4), // Add space for the border
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // White border color
                      width: 4.0, // Thickness of the border
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50, // Original size of the profile image
                    backgroundImage: const NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg',
                    ),
                    backgroundColor:
                        Colors.white, // Keep the inner background white
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Gustavo Lipshutz',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 4),
              Text('Open to work'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'UI/UX Designer, Web Design, Mobile App Design',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
