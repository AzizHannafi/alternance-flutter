import 'package:alternance_flutter/views/auth/userstate/student_sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';

class StudentSignUp extends StatefulWidget {
  final StudentSignUpState state;

  const StudentSignUp({Key? key, required this.state}) : super(key: key);

  @override
  _StudentSignUpState createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.state.firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            hintText: 'Enter your first name',
            prefixIcon: Icon(Icons.person_outline),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.state.lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            hintText: 'Enter your last name',
            prefixIcon: Icon(Icons.person_outline),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != widget.state.dateOfBirth) {
              setState(() {
                widget.state.dateOfBirth = picked;
              });
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              hintText: 'Select your date of birth',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsUtils.primaryGreen),
              ),
            ),
            child: Text(
              widget.state.dateOfBirth == null
                  ? 'Select your date of birth'
                  : '${widget.state.dateOfBirth!.day}/${widget.state.dateOfBirth!.month}/${widget.state.dateOfBirth!.year}',
            ),
          ),
        ),
      ],
    );
  }
}