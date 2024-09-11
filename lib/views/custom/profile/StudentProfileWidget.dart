import 'package:alternance_flutter/model/Student.dart';
import 'package:flutter/material.dart';

class StudentProfileWidget extends StatefulWidget {
  Student student;
  StudentProfileWidget({super.key, required this.student});

  @override
  State<StudentProfileWidget> createState() => _StudentProfileWidgetState();
}

class _StudentProfileWidgetState extends State<StudentProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 370, // Set a maximum height for the education section
      ),
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
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
                  child: const CircleAvatar(
                    radius: 50, // Original size of the profile image
                    backgroundImage: NetworkImage(
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
          Text(
            widget.student.firstName,
            style: const TextStyle(
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
              Text("Student"),
            ],
          ),
          SizedBox(height: 8),
          Text(
            widget.student.headline,
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
    ;
  }
}
