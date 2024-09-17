import 'package:alternance_flutter/model/applicationOfferStudent/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/ApplicationDto.dart';
import '../utils/ColorsUtils.dart';

class ApplicationCardContent extends StatelessWidget {
  final Application application;

  ApplicationCardContent({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(color: ColorsUtils.primaryGreen,),
          const SizedBox(height: 8),
          // Status
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: ColorsUtils.getStatusColor(application.status),
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

          // Offer Title
          Text(
            'Offer: ${application.offer.title}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 8),

          // University Name
          Text(
            'University: ${application.offer.university.universityName}',
            style: const TextStyle(
              fontSize: 16,
              color: ColorsUtils.primaryBleu,
            ),
          ),
          const SizedBox(height: 8),

          // Student Full Name
          Text(
            'Student: ${application.student.firstName} ${application.student.lastName}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Student Skills (if available)
          /*if (application.student.skills != null) ...[
            Text(
              'Skills: ${application.student.skills.join(', ')}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
          ],*/

          // Description (if available)
          if (application.description.isNotEmpty) ...[
            Text(
              'Description: ${application.description}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Application Date
          Text(
            'Application Date: ${DateFormat('yyyy-MM-dd').format(application.applicationDate)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),

        ],
      ),
    );
  }
}
