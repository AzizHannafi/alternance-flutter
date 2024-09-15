import 'package:alternance_flutter/service/application/ApplicationService.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/model/ApplicationDto.dart';
import 'package:intl/intl.dart';

class ApplicationTable extends StatefulWidget {
  final int studentId;

  ApplicationTable({required this.studentId});

  @override
  _ApplicationTableState createState() => _ApplicationTableState();
}

class _ApplicationTableState extends State<ApplicationTable> {
  late Future<List<ApplicationDto>> _futureApplications;
  final Applicationservice _applicationService = Applicationservice();

  @override
  void initState() {
    super.initState();
    // Fetch applications when the widget is initialized
    _futureApplications =
        _applicationService.fetchApplicationByStudent(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ApplicationDto>>(
      future: _futureApplications,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading spinner while data is being fetched
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Display error message if something goes wrong
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Data has been fetched and is available
          final applications = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // To handle large tables
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Offer Title',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Company Name',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Application Date',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: applications
                    .map(
                      (application) => DataRow(
                        cells: [
                          DataCell(Text(application.offer.title)),
                          DataCell(Text(application.offer.company.companyName)),
                          DataCell(Text(DateFormat('yyyy-MM-dd')
                              .format(application.applicationDate))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: _getStatusColor(application.status),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                application.status,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        } else {
          // If no data is available
          return const Center(child: Text('No applications found.'));
        }
      },
    );
  }

  // Function to map the status to a color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey; // default color for unknown status
    }
  }
}
