import 'package:alternance_flutter/model/applicationOfferStudent/Application.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplicationCompanyUniversityCard extends StatefulWidget {
  final Application application;

  const ApplicationCompanyUniversityCard({super.key,required this.application});

  @override
  State<ApplicationCompanyUniversityCard> createState() => _ApplicationCompanyUniversityCardState();
}

class _ApplicationCompanyUniversityCardState extends State<ApplicationCompanyUniversityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsUtils.getStatusColor(widget.application.status),
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
              widget.application.offer.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text(
              widget.application.offer.university.universityName!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('yyyy-MM-dd').format(widget.application.applicationDate),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.application.student.firstName} ${widget.application.student.lastName}'  !,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(widget.application.student.headline == null ? "N/A":
                  '${widget.application.student.headline} ' ,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: ColorsUtils.getStatusColor(widget.application.status),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.application.status.toUpperCase(),
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
}
