import 'package:alternance_flutter/views/auth/userstate/university_sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';

class UniversitySignUp extends StatefulWidget {
  final UniversitySignUpState state;

  const UniversitySignUp({Key? key, required this.state}) : super(key: key);

  @override
  _UniversitySignUpState createState() => _UniversitySignUpState();
}

class _UniversitySignUpState extends State<UniversitySignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.state.universityNameController,
          decoration: const InputDecoration(
            labelText: 'University Name',
            hintText: 'Enter your university name',
            prefixIcon: Icon(Icons.school_outlined),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your university name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.state.locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            hintText: 'Enter your university location',
            prefixIcon: Icon(Icons.location_on_outlined),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your university location';
            }
            return null;
          },
        ),
      ],
    );
  }
}