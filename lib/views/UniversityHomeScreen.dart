import 'package:alternance_flutter/views/CompanyRecommandation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/ColorsUtils.dart';
import 'StudentRecommandation.dart';
import 'application/ApplicationCardView.dart';

class UniversityHomeScreen extends StatelessWidget {
  final int  profileId;
  const UniversityHomeScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        color: ColorsUtils.lightGray,
        child: Column(
          children: [
            StudentRecommandation(),
            //OfferRecommendation(),
            Divider(height: 0),
            /*ApplicationTable(
                    studentId: profileId!,
                  ),*/
            //Divider(height: 0),
            ApplicationCardView(
              profileId: profileId!,role: "company",
            ),
            Divider(height: 0),

            //Divider(height: 0),
            //CompanyRecommandation(),
            //Divider(height: 0),
            CompanyRecommandation()
          ],
        ),
      ),
    );
  }
}
