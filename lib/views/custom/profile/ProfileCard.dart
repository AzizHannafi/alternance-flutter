
import 'package:alternance_flutter/model/user/UserProfile.dart';
import 'package:alternance_flutter/views/CompanytProfileWidget.dart';
import 'package:alternance_flutter/views/UniversityProfileWidget.dart';
import 'package:alternance_flutter/views/custom/profile/StudentProfileWidget.dart';
import 'package:flutter/material.dart';

import '../../../model/user/Company.dart';
import '../../../model/user/Student.dart';
import '../../../model/user/University .dart';

class ProfileCard extends StatefulWidget {
  final UserProfile profile;
  final bool isEditable;
  ProfileCard({required this.profile, Key? key,required this.isEditable}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.profile is Student) {
      return StudentProfileWidget(student: widget.profile as Student,isEditable: widget.isEditable);
    }  if (widget.profile is Company) {
      return CompanyProfileWidget(company: widget.profile as Company,isEditable: widget.isEditable);
    }
      if (widget.profile is University) {
        return Universityprofilewidget(university: widget.profile as University,isEditable: widget.isEditable);

    }else {
      return const Center(
        child: Text("Unknown Profile Type"),
      );
    }
  }
}
