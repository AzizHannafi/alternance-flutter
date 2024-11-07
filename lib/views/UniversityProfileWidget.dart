import 'package:alternance_flutter/service/univesrsity/UniversityService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user/University .dart';
import '../utils/ColorsUtils.dart';

class Universityprofilewidget extends StatefulWidget {
  final University  university;
  final bool isEditable;
  Universityprofilewidget({super.key, required this.university,required this.isEditable});

  @override
  State<Universityprofilewidget> createState() => _CompanyProfileWidgetState();
}

class _CompanyProfileWidgetState extends State<Universityprofilewidget> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: '${widget.university.universityName}',
    );

    _locationController = TextEditingController(
        text: widget.university.location == "" || widget.university.location ==null
            ? "Add your company location."
            : widget.university.location);

  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {

        widget.university.universityName = _nameController.text;
        widget.university.location = _locationController.text;
        // Add more save logic if needed
      }
    });
  }

  void _saveProfile() async {
    // Create a new Student object with updated data
    University university = University(
      id: widget.university.id,
      userId: widget.university.userId,
      universityName: widget.university.universityName,
      location: widget.university.location,
      about: widget.university.about,
      socialMedia: widget.university.socialMedia,
      createdAt: widget.university.createdAt,
      updatedAt: widget.university.updatedAt,
      contactInfo: widget.university.contactInfo,
    );

    try {
      // Attempt to update the profile and get the updated student
      // Student updatedProfile =
      final UniversityService service = UniversityService();
      await service.updateProfile(widget.university.id, university);

      // If the update is successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Profile updated successfully',
                style: const TextStyle(color: ColorsUtils.primaryGreen))),
      );
    } catch (e) {
      print(e);
      // If an error occurs, show a failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update profile: $e.',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
  }

  Widget _buildEditableField({
    required TextEditingController textController,
    required String label,
  }) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 30, // Set a specific height to control the size
        child: Padding(
          padding: EdgeInsets.zero, // Remove padding around the TextField
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            enabled: _isEditing,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *
            0.35, // Set a maximum height for the education section
      ),
      // padding: const EdgeInsets.all(25.0),
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
      child: Stack(
        children: [
          Column(
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
                        backgroundImage: AssetImage('images/student.png'),
                        backgroundColor: ColorsUtils
                            .lightGray, // Keep the inner background white
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 4),
                  Text("University"),
                ],
              ),
              _buildEditableField(
                textController: _nameController,
                label: '${widget.university.universityName}',
              ),

              _buildEditableField(
                textController: _locationController,
                label: '${ widget.university.location}',
              ),

            ],
          ),
          Visibility(
            visible: widget.isEditable,
            child: Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_isEditing) {
                    _toggleEditing();
                    _saveProfile(); // Save the profile if in editing mode
                  } else {
                    _toggleEditing(); // Toggle editing mode if not already editing
                  }
                },
              ),
            ),
          )
          ,
        ],
      ),
    );
  }
}
