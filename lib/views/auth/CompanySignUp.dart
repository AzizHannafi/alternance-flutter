import 'package:alternance_flutter/views/auth/userstate/company_sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';

class CompanySignUp extends StatefulWidget {
  final CompanySignUpState state;

  const CompanySignUp({Key? key, required this.state}) : super(key: key);

  @override
  _CompanySignUpState createState() => _CompanySignUpState();
}

class _CompanySignUpState extends State<CompanySignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.state.companyNameController,
          decoration: const InputDecoration(
            labelText: 'Company Name',
            hintText: 'Enter your company name',
            prefixIcon: Icon(Icons.business),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your company name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.state.locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            hintText: 'Enter your company location',
            prefixIcon: Icon(Icons.location_on_outlined),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your company location';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.state.industryController,
          decoration: const InputDecoration(
            labelText: 'Industry',
            hintText: 'Enter your company industry',
            prefixIcon: Icon(Icons.category_outlined),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.primaryGreen),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your company industry';
            }
            return null;
          },
        ),
      ],
    );
  }
}