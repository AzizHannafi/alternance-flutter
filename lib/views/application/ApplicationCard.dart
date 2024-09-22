import 'package:alternance_flutter/model/ApplicationDto.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplicationCard extends StatelessWidget {
  final dynamic application;

  ApplicationCard({required this.application});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getStatusColor(application.status),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              application.offer.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text(
              application.offer.company.companyName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('yyyy-MM-dd').format(application.applicationDate),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _getStatusColor(application.status),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                application.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.lightBlue;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.grey;
      case 'shortlisted':
        return const Color.fromARGB(255, 252, 192, 102);
      case 'validated':
        return ColorsUtils.primaryGreen;
      case 'invalidated':
        return Colors.red;
      default:
        return Colors.grey; // Default color for unknown status
    }
  }
}
