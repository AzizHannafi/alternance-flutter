import 'package:alternance_flutter/model/Certificate.dart';
import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/model/Student.dart';
import 'package:alternance_flutter/model/UserProfile.dart';
import 'package:alternance_flutter/service/Student/StudentService.dart';
import 'package:alternance_flutter/service/certificate/CertificateService.dart';
import 'package:alternance_flutter/service/education/EducationService.dart';
import 'package:alternance_flutter/service/experience/ExperienceService.dart';
import 'package:alternance_flutter/utils/SharedPreferencesUtils.dart';
import 'package:alternance_flutter/views/certificate/CertificateList.dart';
import 'package:alternance_flutter/views/education/EducationList.dart';
import 'package:alternance_flutter/views/experience/AddExperience.dart';
import 'package:alternance_flutter/views/experience/ExperienceList.dart';
import 'package:alternance_flutter/views/custom/profile/ProfileReusableSection.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/views/custom/profile/ReusableSection.dart';
import 'package:alternance_flutter/views/custom/profile/ProfileCard.dart';
import 'package:alternance_flutter/model/Education.dart';

class Profile extends StatefulWidget {
  final int userId;

  const Profile({
    super.key,
    required this.userId,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserProfile> _profileFuture;
  late Future<List<Education>> _educationFuture;
  late Future<List<Experience>> _experienceFuture;
  late Future<List<Certificate>> _certificateFuture;
  String _role = "";
  int profileId = 0;
  late dynamic _service;

  Future<void> _initializePreferences() async {
    // Await for SharedPreferences initialization
    await SharedPreferencesUtils.init();

    // Load the user role after the preferences are initialized
    setState(() {
      _role = SharedPreferencesUtils.getValue<String>("role") ?? "";
    });

    // Initialize the service based on role
    if (_role.contains("student")) {
      _service = Studentservice();
      _profileFuture = _service.fetchProfile(widget.userId);

      // Fetch data after fetching the profile
      _profileFuture.then((profile) {
        setState(() {
          profileId = profile.id;
          _educationFuture = Educationservice().fetchEducationById(profile.id);
          _experienceFuture =
              Experienceservice().fetchExperienceById(profile.id);
          _certificateFuture =
              Certificateservice().fetchCertificateById(profile.id);
        });
      }).catchError((error) {
        // Handle any errors that occur during fetching
        setState(() {
          // Optionally handle or log errors here
        });
      });
    } else {
      throw Exception("Unsupported role: $_role");
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  bool isStudent() {
    return _role.contains("student");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder: (context, profileSnapshot) {
          if (profileSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (profileSnapshot.hasError) {
            return Center(child: Text('Error: ${profileSnapshot.error}'));
          } else if (!profileSnapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final profile = profileSnapshot.data!;

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileCard(profile: profile),
                    const SizedBox(height: 16.0),

                    Container(
                      child: Profilereusablesection(
                        title: 'About Me',
                        content: Text(profile.about!),
                        profile: profile,
                        maxHeight: MediaQuery.of(context).size.height * 0.17,
                        isAbout: true,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      child: Profilereusablesection(
                        title: 'Contact Information',
                        isAbout: false,
                        profile: profile,
                        content: Text(
                          profile.contactInfo!,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        maxHeight: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Fetch and display education list
                    if (isStudent()) ...[
                      FutureBuilder<List<Education>>(
                        future: _educationFuture,
                        builder: (context, educationSnapshot) {
                          if (educationSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (educationSnapshot.hasError) {
                            return Center(
                                child:
                                    Text('Error: ${educationSnapshot.error}'));
                          } else if (!educationSnapshot.hasData ||
                              educationSnapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No education data found'));
                          }

                          final educationList = educationSnapshot.data!;

                          return Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: ReusableSection(
                              title: 'Education',
                              content:
                                  EducationList(educationList: educationList),
                              maxHeight: 300,
                              addElement: AddExperience(studentId: profileId),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      FutureBuilder<List<Experience>>(
                        future: _experienceFuture,
                        builder: (context, experienceSnapshot) {
                          if (experienceSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (experienceSnapshot.hasError) {
                            return Center(
                                child:
                                    Text('Error: ${experienceSnapshot.error}'));
                          } else if (!experienceSnapshot.hasData ||
                              experienceSnapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No Experience data found'));
                          }

                          final experienceList = experienceSnapshot.data!;

                          return Container(
                            child: ReusableSection(
                              title: 'Experience',
                              content: ExperienceList(
                                  experienceList: experienceList),
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                              addElement: AddExperience(studentId: profileId),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      FutureBuilder<List<Certificate>>(
                        future: _certificateFuture,
                        builder: (context, certificateSnapshot) {
                          if (certificateSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (certificateSnapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Error: ${certificateSnapshot.error}'));
                          } else if (!certificateSnapshot.hasData ||
                              certificateSnapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No certificate data found'));
                          }

                          final certificateList = certificateSnapshot.data!;

                          return Container(
                            child: ReusableSection(
                              title: 'Certificates',
                              content: CertificateList(
                                  certificateList: certificateList),
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                              addElement: AddExperience(studentId: profileId),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
