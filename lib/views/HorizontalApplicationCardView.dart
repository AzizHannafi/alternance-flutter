import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/ApplicationDto.dart';
import '../service/application/ApplicationService.dart';
import '../utils/ColorsUtils.dart';
import 'HorizontalApplicationCard.dart';

class Horizontalapplicationcardview extends StatefulWidget {
  final int userId;
  Horizontalapplicationcardview({super.key, required this.userId});

  @override
  State<Horizontalapplicationcardview> createState() => _HorizontalapplicationcardviewState();
}

class _HorizontalapplicationcardviewState extends State<Horizontalapplicationcardview> {
  late Future<List<ApplicationDto>> _applicationsFuture;

  @override
  void initState() {
    super.initState();
    _applicationsFuture =
        Applicationservice().fetchApplicationByStudent(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder<List<ApplicationDto>>(
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
                          child: Horizontalapplicationcard(application: application),
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
