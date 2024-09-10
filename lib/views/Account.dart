import 'package:alternance_flutter/model/Education.dart';
import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/views/EducationList.dart';
import 'package:alternance_flutter/views/ExperienceList.dart';
import 'package:alternance_flutter/views/ReusableSection.dart';
import 'package:alternance_flutter/views/custom/ProfileCard.dart';
import 'package:flutter/material.dart'; // Ensure this import is present

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final educationList = [
    Education(
      id: 1,
      school: "University Sesame",
      degree: "Bachelor of Science",
      fieldOfStudy: "Computer Science",
      location: "City of Example",
      locationType: "On Site",
      startDate: DateTime(2020, 9, 1),
      endDate: DateTime(2024, 6, 30),
      grade: "A",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida, nisi a maximus vehicula, urna elit tincidunt justo, a tempor risus felis vel justo.",
      studentId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Education(
      id: 1,
      school: "University Tekup",
      degree: "Bachelor of Science",
      fieldOfStudy: "Computer Science",
      location: "City of Example",
      locationType: "On Site",
      startDate: DateTime(2020, 9, 1),
      endDate: DateTime(2024, 6, 30),
      grade: "A",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida, nisi a maximus vehicula, urna elit tincidunt justo, a tempor risus felis vel justo.",
      studentId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<Experience> experienceList = [
    Experience(
      id: 1,
      jobTitle: "Software Developer",
      employmentType: "Full-time",
      companyName: "Tech Solutions Inc.",
      location: "San Francisco, CA",
      locationType: "On Site",
      currentlyWorking: true,
      startDate: DateTime(2022, 1, 1),
      endDate: DateTime(2024, 6, 1),
      description: "Developing web applications using Node.js and React.",
      studentId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Experience(
      id: 2,
      jobTitle: "UI/UX Designer",
      employmentType: "Part-time",
      companyName: "Creative Designs LLC",
      location: "Remote",
      locationType: "Remote",
      currentlyWorking: false,
      startDate: DateTime(2021, 5, 15),
      endDate: DateTime(2022, 12, 31),
      description:
          "Designed user interfaces and experiences for various clients.",
      studentId: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    // Add more Experience entries as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileCard(),
                  const SizedBox(height: 16.0), // Add spacing
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height *
                          0.2, // Adjust max height as needed
                    ),
                    child: ReusableSection(
                      title: 'About Me',
                      content: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Libero, cursus molestie nullam ac pharetra est nec enim. Vel eleifend semper nunc faucibus donec pretium.',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onEdit: () {
                        // Add your edit functionality here
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0), // Add spacing
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height *
                          0.2, // Adjust max height as needed
                    ),
                    child: ReusableSection(
                      title: 'Contact Information',
                      content: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Libero, cursus molestie nullam ac pharetra est nec enim. Vel eleifend semper nunc faucibus donec pretium.',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onEdit: () {
                        // Add your edit functionality here
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0), // Add spacing
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height *
                          0.3, // Adjust max height as needed
                    ),
                    child: ReusableSection(
                      title: 'Education',
                      content: EducationList(educationList: educationList),
                      onEdit: () {
                        // Add your edit functionality here
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0), // Add spacing
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height *
                          0.3, // Adjust max height as needed
                    ),
                    child: ReusableSection(
                      title: 'Experience',
                      content: ExperienceList(
                          experienceList:
                              experienceList), // Pass the experience list
                      onEdit: () {
                        // Add your edit functionality here
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
