import 'package:alternance_flutter/service/Student/StudentService.dart';
import 'package:alternance_flutter/views/StudentCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Student.dart';
import '../utils/ColorsUtils.dart';
import 'NoData.dart';

class StudentRecommandation extends StatefulWidget {
  const StudentRecommandation({super.key});

  @override
  State<StudentRecommandation> createState() => _StudentRecommandationState();
}

class _StudentRecommandationState extends State<StudentRecommandation> {
  late Future<List<Student>> _futureStudent;

  @override
  void initState() {
    super.initState();
    final studentService = Studentservice();
    _futureStudent = studentService.fetchStudent();
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
                  "Students Recommendation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.primaryBleu,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Student>>(
              future: _futureStudent,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Container(
                        height: 300,
                        child: Nodata(filed: "No Student available"),
                      ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Container(
                        height: 300,
                        child: Nodata(filed: "No Student available"),
                      ));
                } else {
                  // Extract the list of offers from the Offers object
                  final students = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: students
                          .map((student) => StudentCard(student: student))
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
