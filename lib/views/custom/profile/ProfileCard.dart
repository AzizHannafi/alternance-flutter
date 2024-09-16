import 'package:alternance_flutter/model/Company.dart';
import 'package:alternance_flutter/model/Student.dart';
import 'package:alternance_flutter/model/University%20.dart';
import 'package:alternance_flutter/model/UserProfile.dart';
import 'package:alternance_flutter/views/CompanytProfileWidget.dart';
import 'package:alternance_flutter/views/UniversityProfileWidget.dart';
import 'package:alternance_flutter/views/custom/profile/StudentProfileWidget.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final UserProfile profile;
  ProfileCard({required this.profile, Key? key}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.profile is Student) {
      return StudentProfileWidget(student: widget.profile as Student);
    }  if (widget.profile is Company) {
      return CompanyProfileWidget(company: widget.profile as Company);
    }
      if (widget.profile is University) {
        return Universityprofilewidget(university: widget.profile as University);

    }else {
      return const Center(
        child: Text("Unknown Profile Type"),
      );
    }
  }
}
