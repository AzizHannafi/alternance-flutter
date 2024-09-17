import 'package:alternance_flutter/views/ApplicationCardContent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/ApplicationDto.dart';
import '../model/applicationOfferStudent/Application.dart';
import '../service/application/ApplicationService.dart';
import '../utils/ColorsUtils.dart';
import 'HorizontalApplicationCard.dart';

class Horizontalapplicationcardview extends StatefulWidget {
  final int profileId;
  final String role;
  Horizontalapplicationcardview({super.key, required this.profileId,required this.role});

  @override
  State<Horizontalapplicationcardview> createState() => _HorizontalapplicationcardviewState();
}

class _HorizontalapplicationcardviewState extends State<Horizontalapplicationcardview> {
  late Future<List<dynamic>> _applicationsFuture;
  //late Future<List<Application>> _applications;


  @override
  void initState() {
    super.initState();
    if(widget.role.contains("student")){
      _applicationsFuture =
          Applicationservice().fetchApplicationByStudent(widget.profileId);
    }else if (widget.role.contains("company")){
      _applicationsFuture = Applicationservice().fetchApplicationByCompany(widget.profileId);

    }else if (widget.role.contains("university")){
      _applicationsFuture = Applicationservice().fetchApplicationByUniversity(widget.profileId);

    }

  }

  @override
  Widget build(BuildContext context) {

    bool isStudent() {
      return widget.role.contains("student");
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      //color: Colors.white,// Adds padding around the container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Applications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsUtils.primaryBleu,
            ),
          ),
          const SizedBox(height: 16.0), // Space between the title and the content
          Expanded( // Ensures this section takes all available space
            child: FutureBuilder<List<dynamic>>(
              future: _applicationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No applications found.'));
                } else {
                  final applications = snapshot.data!;
                  return ListView.builder(
                    itemCount: applications.length,
                    itemBuilder: (context, index) {
                      final application = applications[index];
                      return Container(
                        width: double.infinity, // Define a width for each item
                        margin: const EdgeInsets.only(bottom: 16.0), // Space between items
                        child: Center(
                          child: isStudent() ? Horizontalapplicationcard(application: application):ApplicationCardContent(application: application),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
