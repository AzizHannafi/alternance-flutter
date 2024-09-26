import 'package:alternance_flutter/model/Student.dart';
import 'package:alternance_flutter/utils/DateUtilsC.dart';
import 'package:alternance_flutter/views/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/ColorsUtils.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewProfile(userId:student.userId ,role: "student",),
            ));

      },
      child: Card(
        elevation: 4, // Set the elevation to create a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        margin: const EdgeInsets.all(8.0),
        child: Container(
          width: 350,
          // Constrain the width of the OfferCard
          height: 200,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorsUtils.primaryBleu, // Your custom color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${student.firstName!} ${student.lastName!}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.primaryWhite),
              ),
              const SizedBox(height: 8),
              Text(
                student.about == null || student.about == "" ? "N/A" : student.about!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorsUtils.primaryWhite),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const  Text(
                        'Headline',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite),
                      ),
                      Text(
                        student.headline == null
                            ? "N/A"
                            : '${student.headline}',
                        style:const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date of birth',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite,
                          )),
                      Text(
                          student.dateOfBirth == null
                              ? "N/A"
                              : '${DateUtilsC.formatDateString(student.dateOfBirth)}',
                          style:const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite,
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
