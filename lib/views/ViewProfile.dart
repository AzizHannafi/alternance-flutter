import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Certificate.dart';
import '../model/Education.dart';
import '../model/Experience.dart';
import '../model/user/UserProfile.dart';
import '../service/Student/StudentService.dart';
import '../service/certificate/CertificateService.dart';
import '../service/company/CompanyService.dart';
import '../service/education/EducationService.dart';
import '../service/experience/ExperienceService.dart';
import '../service/univesrsity/UniversityService.dart';
import '../utils/ColorsUtils.dart';
import 'NoData.dart';
import 'certificate/AddCertificate.dart';
import 'certificate/CertificateList.dart';
import 'custom/profile/ProfileCard.dart';
import 'custom/profile/ProfileReusableSection.dart';
import 'custom/profile/ReusableSection.dart';
import 'education/AddEducation.dart';
import 'education/EducationList.dart';
import 'experience/AddExperience.dart';
import 'experience/ExperienceList.dart';

class ViewProfile extends StatefulWidget {
  final int userId;
  final String role;
  const ViewProfile({super.key,required this.userId, required this.role});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late Future<UserProfile> _profileFuture;
  late Future<List<Education>> _educationFuture;
  late Future<List<Experience>> _experienceFuture;
  late Future<List<Certificate>> _certificateFuture;
  int profileId = 0;

  Future<void> _initializePreferences() async {

    // Initialize the service based on role
    if (widget.role.contains("student")) {
      final Studentservice service = Studentservice();
      _profileFuture = service.fetchProfile(widget.userId);

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
      });
    } else if (widget.role.contains("company")) {
      final Companyservice service = Companyservice();
      _profileFuture = service.fetchProfile(widget.userId);

      // Fetch data after fetching the profile
      _profileFuture.then((profile) {
        setState(() {
          profileId = profile.id;

        });
      }).catchError((error) {
        print('*****************$error');
      });

    } else if(widget.role.contains("university")){
      final UniversityService service = UniversityService();
      _profileFuture = service.fetchProfile(widget.userId);

      // Fetch data after fetching the profile
      _profileFuture.then((profile) {
        setState(() {
          profileId = profile.id;

        });
      });
    } else {
      throw Exception("Unsupported role");
    }
  }
  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  bool isStudent() {
    return widget.role.contains("student");
  }

  bool isCompany() {
    return widget.role.contains("company");
  }

  bool isUniversity() {
    return widget.role.contains("university");
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        body: _profileFuture == null
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<UserProfile>(
          future: _profileFuture,
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (profileSnapshot.hasError) {
              return Center(
                  child: Text('Error: ${profileSnapshot.error}'));
            } else if (!profileSnapshot.hasData ||
                profileSnapshot.data == null) {
              return const Center(child: Text('No profile data found'));
            }

            final profile = profileSnapshot.data!;

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileCard(profile: profile,isEditable:false,),
                      const SizedBox(height: 16.0),

                      Container(
                        child: Profilereusablesection(
                          title: 'About',
                          content: Text(profile.about == null
                              ? ""
                              : profile.about!),
                          profile: profile,
                          maxHeight:
                          MediaQuery.of(context).size.height * 0.17,
                          isAbout: true,
                          icon: const Icon(
                            Icons.info_outline,
                            color: ColorsUtils.primaryBleu,
                          ),
                          isEditable: false,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        child: Profilereusablesection(
                          title: 'Contact Information',
                          content: Text(
                            profile.contactInfo == null
                                ? ""
                                : profile.contactInfo!,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          profile: profile,
                          isAbout: false,
                          maxHeight:
                          MediaQuery.of(context).size.height * 0.15,
                          icon: const Icon(
                            Icons.phone_android_sharp,
                            color: ColorsUtils.primaryBleu,
                          ),
                          isEditable: false,
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
                                  child: Text(
                                      'Error: ${educationSnapshot.error}'));
                              // } else if (!educationSnapshot.hasData ||
                              //     educationSnapshot.data!.isEmpty) {
                              //   return const Center(
                              //       child: Text('No education data found'));
                            }

                            final educationList = educationSnapshot.data!;

                            return Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                MediaQuery.of(context).size.height *
                                    0.3,
                              ),
                              child: ReusableSection(
                                title: 'Education',
                                content: educationList.isEmpty
                                    ? const Nodata(
                                  filed: "Education",
                                )
                                    : EducationList(
                                    educationList: educationList,isEditable: false,),
                                maxHeight: 300,
                                addElement:
                                Addeducation(studentId: profileId),
                                isEditable: false,
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
                                  child: Text(
                                      'Error: ${experienceSnapshot.error}'));
                              // } else if (!experienceSnapshot.hasData ||
                              //     experienceSnapshot.data!.isEmpty) {
                              //   return const Center(
                              //       child:
                              //           Text('No Experience data found'));
                            }

                            final experienceList =
                            experienceSnapshot.data!;

                            return Container(
                              child: ReusableSection(
                                title: 'Experience',
                                content: experienceList.isEmpty
                                    ? const Nodata(
                                  filed: "Experience",
                                )
                                    : ExperienceList(
                                    experienceList: experienceList,isEditable: false),
                                maxHeight:
                                MediaQuery.of(context).size.height *
                                    0.3,
                                addElement:
                                AddExperience(studentId: profileId),
                                isEditable: false,
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
                              // } else if (!certificateSnapshot.hasData ||
                              //     certificateSnapshot.data!.isEmpty) {
                              //   return const Center(
                              //       child:
                              //           Text('No certificate data found'));
                            }

                            final certificateList =
                            certificateSnapshot.data!;

                            return Container(
                              child: ReusableSection(
                                title: 'Certificates',
                                content: certificateList.isEmpty
                                    ? const Nodata(
                                  filed: "Certificates",
                                )
                                    : CertificateList(
                                    certificateList: certificateList,isEditable: false),
                                maxHeight:
                                MediaQuery.of(context).size.height *
                                    0.3,
                                addElement:
                                Addcertificate(studentId: profileId),
                                isEditable: false,
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
        ));
  }
}
