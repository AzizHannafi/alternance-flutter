import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/ApplicationDto.dart';
import '../utils/ColorsUtils.dart';

class Horizontalapplicationcard extends StatelessWidget {
  final ApplicationDto application;
  Horizontalapplicationcard({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 7,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      //margin: const EdgeInsets.symmetric(vertical: 8.0),

      child: Container(
        width: double.infinity,
        
        padding: EdgeInsets.only(right: 20,left: 20,bottom: 10,top: 10),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: _getStatusColor(application.status),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                application.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Offer :${application.offer.title}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 8),
            Text(
              'Company Name: ${application.offer.company.companyName}',
              style: const TextStyle(
                fontSize: 16,
                color: ColorsUtils.primaryBleu,
              ),
            ),
            const SizedBox(height: 8),
            Text('Application Date :${DateFormat('yyyy-MM-dd').format(application.applicationDate)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
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
