import 'package:alternance_flutter/service/company/CompanyService.dart';
import 'package:alternance_flutter/views/HorizontalApplicationCardView.dart';
import 'package:flutter/material.dart';

import '../../model/user/UserProfile.dart';
import '../../service/Student/StudentService.dart';
import '../../service/univesrsity/UniversityService.dart';
import '../../utils/SharedPreferencesUtils.dart';

class Application extends StatefulWidget {

  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();

}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }
  String _role = "";
  int? profileId;
  late Future<UserProfile> _profileFuture;

  Future<void> _initializePreferences() async {
    try {
      // Await for SharedPreferences initialization
      await SharedPreferencesUtils.init();

      // Load the user role after the preferences are initialized
      _role = SharedPreferencesUtils.getValue<String>("role") ?? "";

      // Initialize the service based on role
      if (_role.contains("student")) {
        final Studentservice _service = Studentservice();
        _profileFuture = _service.fetchProfile(SharedPreferencesUtils.getValue<int>("id")!);

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
      } else  if (_role.contains("company")){
        final Companyservice _service = Companyservice();
        _profileFuture = _service.fetchProfile(SharedPreferencesUtils.getValue<int>("id")!);

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
      }
      else  if (_role.contains("university")){
        final UniversityService _service = UniversityService();
        _profileFuture = _service.fetchProfile(SharedPreferencesUtils.getValue<int>("id")!);

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
    return profileId == null ? Center(child: CircularProgressIndicator(),): Center(child: Horizontalapplicationcardview(profileId: profileId!,role : _role),);
  }
}
