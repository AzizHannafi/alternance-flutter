import 'dart:io';

import 'package:alternance_flutter/service/Student/StudentService.dart';
import 'package:alternance_flutter/service/application/ApplicationService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/utils/SharedPreferencesUtils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/user/Student.dart';

class Jobapply extends StatefulWidget {
  final int offerId;
  Jobapply({super.key, required this.offerId});

  @override
  State<Jobapply> createState() => _JobapplyState();
}

class _JobapplyState extends State<Jobapply> {
  bool isResumeUploaded = false; // Track if the resume is uploaded
  final TextEditingController descriptionController = TextEditingController();
  Applicationservice applicationService = Applicationservice();
  File? selectedFile;
  String? selectedFileName;

  String _role = "";
  late int profileId;
  late Future<Student> _profileFuture;
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

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
        _profileFuture =
            _service.fetchProfile(SharedPreferencesUtils.getValue<int>("id")!);

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

  Future<void> uploadResume() async {
    // Use the file picker to pick PDF files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Limit to PDF files only
    );

    if (result != null && result.files.single.path != null) {
      // PDF file selected
      String? path = result.files.single.path;
      File file = File(path!); // Create a File object using the path

      setState(() {
        selectedFile = file; // Store the selected file
        isResumeUploaded = true; // Mark resume as uploaded
        selectedFileName = result.files.single.name; // Store the file name
      });
    } else {
      // User canceled the picker
      setState(() {
        isResumeUploaded = false;
      });
    }
  }

  Future<void> applyJob() async {
    final description = descriptionController.text;

    if (isResumeUploaded && description.isNotEmpty) {
      // Check if the application already exists
      bool applicationExists = await applicationService.checkApplicationExist(profileId, widget.offerId);

      if (applicationExists) {
        // Show error message if the application already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You have already applied for this job.',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        );
        return; // Exit the function if the application exists
      }

      try {
        // Proceed with submitting the application
        await applicationService.applyForJob(
          studentId: profileId,
          offerId: widget.offerId,
          description: description,
          file: selectedFile!,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Application submitted successfully!',
              style: TextStyle(color: ColorsUtils.primaryGreen),
            ),
          ),
        );
      } catch (e) {
        // Handle the error case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Error submitting application',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        );
      }
    } else {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apply for the Job',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight, // Use the remaining height minus the app bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tip Card
                    Card(
                      color: ColorsUtils.primaryWhite,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tip:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorsUtils.primaryGreen,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'You\'re just one step away from applying for this job—congratulations! We highly recommend that you add a brief description of your interest in this position and your motivation for applying. Additionally, uploading your resume will significantly increase your chances of being shortlisted or accepted.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Description TextField
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText:
                            'Describe why you are suitable for this role...',
                        prefixIcon: Icon(
                          Icons.edit_document,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorsUtils.primaryGreen),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Resume upload section
                    const Text(
                      'Upload Resume',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: uploadResume,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isResumeUploaded ? Colors.green : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isResumeUploaded
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf_outlined,
                                        color: Colors.red, size: 50),
                                    if (selectedFileName != null) ...[
                                      const SizedBox(height: 8),
                                      Text(selectedFileName!),
                                    ]
                                  ],
                                )
                              : SvgPicture.asset(
                                  'assets/upload.svg', // Replace Icon with SVG asset
                                  width: 50,
                                  height: 50,
                                  color: ColorsUtils.primaryBleu,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: applyJob,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsUtils.primaryGreen,
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
