
import 'package:alternance_flutter/model/user/UserProfile.dart';
import 'package:alternance_flutter/service/Student/StudentService.dart';
import 'package:alternance_flutter/service/company/CompanyService.dart';
import 'package:alternance_flutter/service/univesrsity/UniversityService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

import '../../../model/user/Company.dart';
import '../../../model/user/Student.dart';
import '../../../model/user/University .dart';

class Profilereusablesection extends StatefulWidget {
  final String title;
  final Widget content;
  final UserProfile profile;
  final double maxHeight;
  final bool isAbout;
  final Icon icon;
  final bool isEditable;

  const Profilereusablesection(
      {super.key,
      required this.title,
      required this.content,
      required this.profile,
      required this.maxHeight,
      required this.isAbout,
      required this.icon,
      required this.isEditable});

  @override
  _ProfilereusablesectionState createState() => _ProfilereusablesectionState();
}

class _ProfilereusablesectionState extends State<Profilereusablesection> {
  bool _isEditing = false;
  late TextEditingController _textFiledController;

  @override
  void initState() {
    super.initState();
    if (widget.profile is Student) {
      Student currentProfile = widget.profile as Student;
      if (widget.isAbout) {
        _textFiledController = TextEditingController(
            text: currentProfile.about ??
                "Provide some information about yourself.");
      } else {
        _textFiledController = TextEditingController(
            text: currentProfile.contactInfo ?? "Enter your phone number.");
      }
    } else if (widget.profile is Company) {
      Company currentProfile = widget.profile as Company;
      if (widget.isAbout) {
        _textFiledController = TextEditingController(
            text: currentProfile.about ??
                "Provide some information about yourself.");
      } else {
        _textFiledController = TextEditingController(
            text: currentProfile.contactInfo ?? "Enter your phone number.");
      }
    }
    else if (widget.profile is University) {
      University currentProfile = widget.profile as University;
      if (widget.isAbout) {
        _textFiledController = TextEditingController(
            text: currentProfile.about ??
                "Provide some information about yourself.");
      } else {
        _textFiledController = TextEditingController(
            text: currentProfile.contactInfo ?? "Enter your phone number.");
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wrap the Icon with an Expanded widget and give it a flex of 1
              Expanded(
                flex: 1, // 1/4 of the Row
                child: widget.icon,
              ),
              // Wrap the TextField with an Expanded widget and give it a flex of 3
              Expanded(
                flex: 7, // 3/4 of the Row
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  maxLines: 5,
                  enabled: _isEditing,
                ),
              ),
            ],
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

  void _saveProfile(UserProfile profile) async {
    // Create a new Student object with updated data
    if (profile is Student){
      Student std = profile;
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
        final Studentservice service = Studentservice();

        await service.updateProfile(std.id, updatedStudent);

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
    if (profile is Company){
      Company cmp = profile;
      Company updatedCompany = Company(
        id: cmp.id,
        userId: cmp.userId,
        companyName: cmp.companyName,
        industry: cmp.industry,
        location: cmp.location,
        about: cmp.about,
        socialMedia: cmp.socialMedia,
        createdAt: cmp.createdAt,
        updatedAt: cmp.updatedAt,
        contactInfo: cmp.contactInfo,
      );
      try {
        final Companyservice service = Companyservice();

        await service.updateProfile(cmp.id, updatedCompany);

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
    if (profile is University){
      University university = profile;
      University updatedUniversity = University(
        id: university.id,
        userId: university.userId,
        universityName: university.universityName,
        location: university.location,
        about: university.about,
        socialMedia: university.socialMedia,
        createdAt: university.createdAt,
        updatedAt: university.updatedAt,
        contactInfo: university.contactInfo,
      );
      try {
        final UniversityService service = UniversityService();

        await service.updateProfile(university.id, updatedUniversity);

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

  }

  @override
  Widget build(BuildContext context) {
    //if (widget.profile is Student) {
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
              Visibility(
                  visible: widget.isEditable,
                  child: IconButton(
                          onPressed: () {
                            if (_isEditing) {
                              _toggleEditing();
                              if (widget.profile is Student) {
                                Student std = widget.profile as Student;
                                _saveProfile(std); // Save the profile if in editing mode

                              }
                              else if (widget.profile is Company){Company cmp = widget.profile as Company;
                              _saveProfile(cmp);}

                              else if (widget.profile is University){
                                University university = widget.profile as University;
                                _saveProfile(university);
                              }
                            }else {
                              _toggleEditing();
                            }
                          },
                        icon: Icon(
                          _isEditing ? Icons.check : Icons.edit,
                          color: ColorsUtils.primaryGreen,
                ),
              )
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
    } /*else {
      return const Center(
        child: Text("Unknown Profile Type"),
      );
    }*/
  //}
}
