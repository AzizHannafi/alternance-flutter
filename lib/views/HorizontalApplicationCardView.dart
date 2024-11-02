import 'package:alternance_flutter/views/NoData.dart';
import 'package:alternance_flutter/views/search/StatusFilterDropdown.dart';
import 'package:flutter/material.dart';
import '../service/application/ApplicationService.dart';
import '../utils/ColorsUtils.dart';
import 'HorizontalApplicationCard.dart';
import 'application/ApplicationCardContent.dart';
import 'application/CondidateDetails.dart';

class Horizontalapplicationcardview extends StatefulWidget {
  final int profileId;
  final String role;

  Horizontalapplicationcardview({super.key, required this.profileId, required this.role});

  @override
  State<Horizontalapplicationcardview> createState() => _HorizontalapplicationcardviewState();
}

class _HorizontalapplicationcardviewState extends State<Horizontalapplicationcardview> {
  late Future<List<dynamic>> _applicationsFuture;
  String? _selectedStatus; // To hold the selected status filter

  @override
  void initState() {
    super.initState();
    _fetchApplications();
  }

  void _fetchApplications() {
    if (widget.role.contains("student")) {
      _applicationsFuture = Applicationservice().fetchApplicationByStudent(widget.profileId);
    } else if (widget.role.contains("company")) {
      _applicationsFuture = Applicationservice().fetchApplicationByCompany(widget.profileId);
    } else if (widget.role.contains("university")) {
      _applicationsFuture = Applicationservice().fetchApplicationByUniversity(widget.profileId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 16.0),
          StatusFilterDropdown(
            selectedStatus: _selectedStatus,
            onStatusChanged: (String? newStatus) {
              setState(() {
                _selectedStatus = newStatus;
                // Optionally, you could trigger a fetch of applications based on the selected status
              });
            },
          ),
          const SizedBox(height: 16.0),
          Expanded(
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
                  // Apply the filter if a status is selected
                  final filteredApplications = _selectedStatus != null
                      ? applications.where((application) => application.status.toLowerCase() == _selectedStatus).toList()
                      : applications;

                  // Check if there are filtered applications
                  if (filteredApplications.isEmpty) {
                    return const Center(child: Nodata(filed: 'No applications found.'));
                  }

                  return ListView.builder(
                    itemCount: filteredApplications.length,
                    itemBuilder: (context, index) {
                      final application = filteredApplications[index];
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: widget.role.contains("student")
                            ? Horizontalapplicationcard(application: application)
                            : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CondidateDetails(
                                  applicationData: application,
                                  role: widget.role,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 7,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ApplicationCardContent(application: application),
                          ),
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
