import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/ColorsUtils.dart';
import 'CompanyRecommandation.dart';
import 'UniversityRecommandation.dart';
import 'application/ApplicationCardView.dart';
import 'offer/OfferRecommandation.dart';

class StudentHomescreen extends StatelessWidget {
  final int  profileId;
  const StudentHomescreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        color: ColorsUtils.lightGray,
        child: Column(
          children: [
            OfferRecommendation(),
            Divider(height: 0),
            /*ApplicationTable(
                    studentId: profileId!,
                  ),*/
            Divider(height: 0),
            ApplicationCardView(
              profileId: profileId!,role: "student",
            ),
            Divider(height: 0),
            CompanyRecommandation(),
            Divider(height: 0),
            UniversityRecommandation()
          ],
        ),
      ),
    );
  }
}
