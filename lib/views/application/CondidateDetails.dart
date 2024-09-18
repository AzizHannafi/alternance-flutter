import 'package:alternance_flutter/model/applicationOfferStudent/Application.dart';
import 'package:alternance_flutter/service/application/ApplicationService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../NoData.dart';

class CondidateDetails extends StatefulWidget {
  final Application applicationData;
  final String role;


   CondidateDetails({super.key, required this.applicationData,required this.role});

  @override
  State<CondidateDetails> createState() => _CondidateDetailsState();



}

class _CondidateDetailsState extends State<CondidateDetails> {
  late Application _application;

  @override
  void initState() {
    super.initState();
    _application = widget.applicationData;
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.applicationData.student;
    final offer = widget.applicationData.offer;
    final university = offer.university;
    final applicationFiles = widget.applicationData.applicationFiles;
    final experiences = student.experiences;
    final education = student.educations;
    final certificates = student.certificates;
    final List<String> allStatusOption = ["rejected","shortlisted","accepted","invalidated","validated","pending"];
    List<String> companyStatusOption = ["rejected","shortlisted","accepted"];
    List<String> universityStatusOption = ["validated","invalidated"];
    String _selectedStatus =  widget.applicationData.status;
    List<String> filteredStatusOptions = companyStatusOption.contains(_selectedStatus)
        ? companyStatusOption
        : [...companyStatusOption, _selectedStatus];

    List<String> universityFilteredStatusOptions = universityStatusOption.contains(_selectedStatus)
        ? universityStatusOption
        : [...universityStatusOption, _selectedStatus];

    void _updateStatus(int applicationId, String status) async{
    try{
      final Applicationservice service = Applicationservice();
      await service.updateApplicationStatus(applicationId, status);
      setState(() {
        _application.status = status; // Update the local copy's status
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Status updated successfully',
                style: const TextStyle(color: ColorsUtils.primaryGreen))),
      );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update Status: $e.',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
    }

    void _showStatusChangeDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String dialogSelectedStatus = widget.applicationData.status; // Local copy for the dialog

          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: Text('Change Application Status'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Please select a new status for the application:'),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: dialogSelectedStatus,
                      items: widget.role.contains("company") ? filteredStatusOptions.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(color: ColorsUtils.getStatusColor(status)),
                          ),
                        );
                      }).toList(): universityFilteredStatusOptions.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(color: ColorsUtils.getStatusColor(status)),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setDialogState(() {
                          dialogSelectedStatus = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {

                      _updateStatus(widget.applicationData.id!, dialogSelectedStatus);

                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      );
    }



    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Candidate Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offer Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${offer.title}',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color:
                    ColorsUtils.getStatusColor(_application.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _application.status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),

            Divider(color: ColorsUtils.primaryGreen),

            // Student Info Card
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: ColorsUtils.primaryWhite,
                          child: SvgPicture.asset(
                            'assets/student.svg',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,

                          ),

                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${student.firstName} ${student.lastName}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${student.headline}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Handle messaging action
                          },
                          child: Icon(
                            Icons.messenger_outline_sharp,
                            color: ColorsUtils.primaryGreen,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // About Section
                    if (student.about != null && student.about!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            student.about!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // Experiences, Education, Certificates
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (experiences != null && experiences.isNotEmpty) ...[
                      const Text(
                        'Experiences:',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...experiences.map<Widget>((experience) {
                        return Row(
                          children: [
                            Icon(Icons.work, color: ColorsUtils.primaryGreen),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${experience.jobTitle}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                    ] else ...[
                      Nodata(filed: "No experience available"),
                      Divider(color: ColorsUtils.primaryGreen,),
                      const SizedBox(height: 16),
                    ],

                    if (education != null && education.isNotEmpty) ...[
                      Text(
                        'Education:',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...education.map<Widget>((edu) {
                        return Row(
                          children: [
                            Icon(Icons.school, color: ColorsUtils.primaryGreen),
                            const SizedBox(width: 8),
                            Text(
                              '${edu.degree}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                    ]else ...[
                      Nodata(filed: "No Education available"),
                      Divider(color: ColorsUtils.primaryGreen,),
                      const SizedBox(height: 16),
                    ],

                    if (certificates != null && certificates.isNotEmpty) ...[
                      Text(
                        'Certificates:',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...certificates.map<Widget>((certificate) {
                        return Row(
                          children: [
                            Icon(Icons.verified, color: ColorsUtils.primaryGreen),
                            const SizedBox(width: 8),
                            Text(
                              '${certificate.certificateName}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                    ]else ...[
                      Nodata(filed: "No Certificates available"),
                      Divider(color: ColorsUtils.primaryGreen,indent: 90,endIndent: 90,),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),

            // Application Info Card
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Application Details",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.applicationData.description.isNotEmpty
                          ? widget.applicationData.description
                          : "No Description provided by the student",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),

                    // Application Date
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: ColorsUtils.primaryGreen),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Application Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.applicationData.applicationDate.toString()))}',
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    // Application Files
                    if (applicationFiles != null && applicationFiles.isNotEmpty) ...[
                      const Text(
                        "Application Files",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      ...applicationFiles.map<Widget>((file) {
                        return Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf_outlined,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${file.fileName}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                    const SizedBox(height: 16),

                    // University Details
                    Row(
                      children: [
                        Icon(Icons.school_outlined, color: ColorsUtils.primaryGreen),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'University: ${university.universityName}',
                            style: const TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: ColorsUtils.primaryGreen),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Location: ${university.location}',
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),


                  ],
                ),
              ),
            )

            ,

            const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity, // Full width of the container
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsUtils.primaryBleu, // Button color
                padding: EdgeInsets.symmetric(vertical: 16.0), // Padding inside the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
              ),
                onPressed: () {
                  _showStatusChangeDialog(context);
                },

              child: Text('Change Status',style: TextStyle(color :Colors.white),), // Text for the button
            ),
          ),
        )

        ],
        ),
      ),
    );
  }

}
