import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/service/application/ApplicationService.dart';
import 'package:alternance_flutter/views/application/ApplicationCard.dart';
import 'package:alternance_flutter/model/ApplicationDto.dart'; // Make sure to import your model

class ApplicationCardView extends StatefulWidget {
  final int studentId;

  ApplicationCardView({required this.studentId});

  @override
  _ApplicationCardViewState createState() => _ApplicationCardViewState();
}

class _ApplicationCardViewState extends State<ApplicationCardView> {
  late Future<List<ApplicationDto>> _applicationsFuture;

  @override
  void initState() {
    super.initState();
    _applicationsFuture =
        Applicationservice().fetchApplicationByStudent(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds padding around the container

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Application",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsUtils.primaryBleu,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<ApplicationDto>>(
              future: _applicationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No applications found.'));
                } else {
                  final applications = snapshot.data!;
                  return SizedBox(
                    height:
                        250.0, // Specify a height for the horizontal ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: applications.length,
                      itemBuilder: (context, index) {
                        final application = applications[index];
                        return Container(
                          width: 150.0, // Define a width for each item
                          margin: const EdgeInsets.only(
                              right: 16.0), // Space between items
                          child: Center(
                            child: ApplicationCard(application: application),
                          ),
                        );
                        // You can replace the Text with ApplicationCard if needed
                      },
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
