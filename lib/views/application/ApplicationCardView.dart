import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/ApplicationCompanyUniversityCard.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/service/application/ApplicationService.dart';
import 'package:alternance_flutter/views/application/ApplicationCard.dart';
import 'package:alternance_flutter/model/ApplicationDto.dart';

import '../NoData.dart'; // Make sure to import your model

class ApplicationCardView extends StatefulWidget {
  final int profileId;
  final String role;

  ApplicationCardView({required this.profileId, required this.role});

  @override
  _ApplicationCardViewState createState() => _ApplicationCardViewState();
}

class _ApplicationCardViewState extends State<ApplicationCardView> {
  late Future<List<dynamic>> _applicationsFuture;

  @override
  void initState() {
    super.initState();
    if (widget.role.contains("student")) {
      _applicationsFuture =
          Applicationservice().fetchApplicationByStudent(widget.profileId);
    } else if (widget.role.contains("company")) {
      _applicationsFuture =
          Applicationservice().fetchApplicationByCompany(widget.profileId);
    } else if (widget.role.contains("university")) {
      _applicationsFuture =
          Applicationservice().fetchApplicationByUniversity(widget.profileId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds padding around the container

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.app_registration, color: ColorsUtils.primaryGreen),
              SizedBox(
                width: 10,
              ),
              Text(
                "Recent Application",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorsUtils.primaryBleu,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<dynamic>>(
              future: _applicationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Container(
                      height: 300,
                      child: Nodata(filed: "No applications found"),
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Container(
                          height: 300,
                          child: Nodata(filed: "No applications found")));
                } else {
                  final applications = snapshot.data!;
                  return SizedBox(
                    height:
                        350.0, // Specify a height for the horizontal ListView
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
                            child: widget.role.contains("student")
                                ? ApplicationCard(application: application)
                                : ApplicationCompanyUniversityCard(
                                    application: application, role: widget.role),
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
