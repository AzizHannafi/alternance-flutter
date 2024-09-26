import 'package:alternance_flutter/model/University%20.dart';
import 'package:alternance_flutter/service/univesrsity/UniversityService.dart';
import 'package:alternance_flutter/views/UniversityCard.dart';
import 'package:alternance_flutter/views/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/ColorsUtils.dart';
import 'NoData.dart';

class UniversityRecommandation extends StatefulWidget {
  const UniversityRecommandation({super.key});

  @override
  State<UniversityRecommandation> createState() =>
      _UniversityRecommandationState();
}

class _UniversityRecommandationState extends State<UniversityRecommandation> {
  late Future<List<University>> _universitFuture;

  @override
  void initState() {
    super.initState();
    final _universityService = UniversityService();
    _universitFuture = _universityService.fetchUniversity();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds padding around the container
      child: Container(
        // height: 400, // Ensure a defined height
        width: double.infinity, // Occupies the full width
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school_outlined, color: ColorsUtils.primaryGreen),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Universities Recommendation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.primaryBleu,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<University>>(
              future: _universitFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Container(
                    height: 300,
                    child: Nodata(filed: "No UniversityUniversity available"),
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Container(
                    height: 300,
                    child: Nodata(filed: "No UniversityUniversity available"),
                  ));
                } else {
                  // Extract the list of offers from the Offers object
                  final universities = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: universities
                          .map((university) =>
                          UniversityCard(university: university)
                      )
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
