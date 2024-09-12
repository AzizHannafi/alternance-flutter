import 'package:alternance_flutter/model/Student.dart';
import 'package:alternance_flutter/model/UserProfile.dart';
import 'package:alternance_flutter/service/Student/StudentService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class Profilereusablesection extends StatefulWidget {
  final String title;
  final Widget content;
  final UserProfile profile;
  final double maxHeight;
  final bool isAbout;

  const Profilereusablesection({
    super.key,
    required this.title,
    required this.content,
    required this.profile,
    required this.maxHeight,
    required this.isAbout,
  });

  @override
  _ProfilereusablesectionState createState() => _ProfilereusablesectionState();
}

class _ProfilereusablesectionState extends State<Profilereusablesection> {
  bool _isEditing = false;
  late TextEditingController _textFiledController;
  Studentservice _service = Studentservice();

  @override
  void initState() {
    super.initState();
    if (widget.profile is Student) {
      Student currentProfile = widget.profile as Student;
      if (widget.isAbout) {
        _textFiledController =
            TextEditingController(text: currentProfile.about);
      } else {
        _textFiledController =
            TextEditingController(text: currentProfile.contactInfo);
      }
    }
  }

  @override
  void dispose() {
    _textFiledController.dispose();
    super.dispose();
  }

  Widget _buildEditableField({
    required TextEditingController textController,
    required String label,
  }) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: SizedBox(
        // width: 200,
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
            textAlign: TextAlign.left,
            maxLines: 5,
            enabled: _isEditing,
          ),
        ),
      ),
    );
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        if (widget.isAbout) {
          widget.profile.about = _textFiledController.text;
        } else {
          widget.profile.contactInfo = _textFiledController.text;
        }
        // Save changes or handle updates here
      }
    });
  }

  void _saveProfile(Student std) async {
    // Create a new Student object with updated data
    Student updatedStudent = Student(
      id: std.id,
      userId: std.userId,
      about: std.about,
      createdAt: std.createdAt,
      updatedAt: std.updatedAt,
      firstName: std.firstName,
      lastName: std.lastName,
      headline: std.headline,
      dateOfBirth: std.dateOfBirth,
      contactInfo: std.contactInfo,
    );

    try {
      // Attempt to update the profile and get the updated student
      // Student updatedProfile =
      await _service.updateProfile(std.id, updatedStudent);

      // If the update is successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Profile updated successfully',
                style: const TextStyle(color: ColorsUtils.primaryGreen))),
      );
    } catch (e) {
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

  @override
  Widget build(BuildContext context) {
    if (widget.profile is Student) {
      Student std = widget.profile as Student;
      return Container(
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight, // Set a maximum height for the section
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: ColorsUtils.primaryBleu,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_isEditing) {
                    _toggleEditing();
                    _saveProfile(std); // Save the profile if in editing mode
                  } else {
                    _toggleEditing(); // Toggle editing mode if not already editing
                  }
                },
                icon: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: ColorsUtils.primaryGreen,
                ),
              )
            ]),
            const SizedBox(height: 8.0),
            Expanded(
                child: _buildEditableField(
              textController: _textFiledController,
              label: widget.title,
            )),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text("Unknown Profile Type"),
      );
    }
  }
}
