import 'package:alternance_flutter/model/UserProfile.dart';
import 'package:alternance_flutter/service/Student/StudentService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/utils/SharedPreferencesUtils.dart';
import 'package:alternance_flutter/views/CompanyRecommandation.dart';
import 'package:alternance_flutter/views/UniversityRecommandation.dart';

import 'package:flutter/material.dart';

import 'application/ApplicationCardView.dart';
import 'application/ApplicationTable.dart';
import 'offer/OfferRecommandation.dart';

class Home extends StatefulWidget {
  final int userId;

  Home({super.key, required this.userId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _role = "";
  int? profileId;
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    try {
      // Await for SharedPreferences initialization
      await SharedPreferencesUtils.init();

      // Load the user role after the preferences are initialized
      _role = SharedPreferencesUtils.getValue<String>("role") ?? "";

      // Initialize the service based on role
      if (_role.contains("student")) {
        final Studentservice _service = Studentservice();
        _profileFuture = _service.fetchProfile(widget.userId);

        // Fetch data after fetching the profile
        _profileFuture.then((profile) {
          setState(() {
            profileId = profile.id;
          });
        }).catchError((error) {
          // Handle any errors that occur during fetching
          setState(() {
            // Optionally handle or log errors here
          });
        });
      } else {
        setState(() {
          // Role is not supported
          _role = "";
        });
      }
    } catch (error) {
      // Handle initialization errors
      setState(() {
        _role = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _role.contains("student")
        ? SingleChildScrollView(
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
                    studentId: profileId!,
                  ),
                  Divider(height: 0),
                  CompanyRecommandation(),
                  Divider(height: 0),
                  UniversityRecommandation()
                ],
              ),
            ),
          )
        : Center(child: Text("You're not a student"));
  }
}
