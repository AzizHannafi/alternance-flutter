import 'package:alternance_flutter/model/Education.dart';
import 'package:alternance_flutter/service/education/EducationService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Educationdetails extends StatefulWidget {
  Education education;
  Educationdetails({super.key, required this.education});

  @override
  State<Educationdetails> createState() => _EducationdetailsState();
}

class _EducationdetailsState extends State<Educationdetails> {
  final _formKey = GlobalKey<FormState>();
  Educationservice srv = Educationservice();
  late TextEditingController schoolController;
  late TextEditingController degreeController;
  late TextEditingController fieldOfStudyController;
  late TextEditingController locationController;
  late TextEditingController gradeController;
  late TextEditingController descriptionController;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the current values
    schoolController = TextEditingController(text: widget.education.school);
    degreeController = TextEditingController(text: widget.education.degree);
    fieldOfStudyController =
        TextEditingController(text: widget.education.fieldOfStudy);
    locationController = TextEditingController(text: widget.education.location);
    gradeController = TextEditingController(text: widget.education.grade);
    descriptionController =
        TextEditingController(text: widget.education.description);
    startDate = widget.education.startDate;
    endDate = widget.education.endDate;
  }

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    schoolController.dispose();
    degreeController.dispose();
    fieldOfStudyController.dispose();
    locationController.dispose();
    gradeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate ? startDate : endDate;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _saveEducation() async {
    if (_formKey.currentState!.validate()) {
      // Create updated education object
      Education updatedEducation = Education(
        id: widget.education.id,
        school: schoolController.text,
        degree: degreeController.text,
        fieldOfStudy: fieldOfStudyController.text,
        location: locationController.text,
        locationType: widget.education.locationType,
        startDate: startDate,
        endDate: endDate,
        grade: gradeController.text,
        description: descriptionController.text,
        studentId: widget.education.studentId,
        createdAt: widget.education.createdAt,
        updatedAt: DateTime.now(), // Update the updatedAt field
      );

      try {
        // Call the API to update the education details
        await srv.updateEducation(updatedEducation);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Education details saved successfully',
            style: TextStyle(color: ColorsUtils.primaryGreen),
          )),
        );

        // Navigate back or perform other actions
        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to save education details: $e',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Education Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // School
                TextFormField(
                  controller: schoolController,
                  decoration: const InputDecoration(
                    labelText: "School",
                    hintText: 'Enter your School',
                    prefixIcon: Icon(Icons.school,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the school';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Degree
                TextFormField(
                  controller: degreeController,
                  decoration: const InputDecoration(
                    labelText: "Degree",
                    prefixIcon: Icon(Icons.book,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the degree';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Field of Study
                TextFormField(
                  controller: fieldOfStudyController,
                  decoration: const InputDecoration(
                    labelText: "Field of Study",
                    prefixIcon: Icon(Icons.menu_book,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the field of study';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Location
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: "Location",
                    prefixIcon: Icon(Icons.location_on,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Start and End Date
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, true),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: "Start Date",
                            prefixIcon: Icon(Icons.date_range,
                                color: ColorsUtils.primaryGreen, size: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsUtils.primaryGreen),
                            ),
                          ),
                          child: Text(DateFormat.yMMMd().format(startDate)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: "End Date",
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: ColorsUtils.primaryGreen,
                              size: 20,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsUtils.primaryGreen),
                            ),
                          ),
                          child: Text(DateFormat.yMMMd().format(endDate)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Grade
                TextFormField(
                  controller: gradeController,
                  decoration: const InputDecoration(
                    labelText: "Grade",
                    prefixIcon: Icon(Icons.grade,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the grade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Description
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    prefixIcon: Icon(Icons.description,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 15),
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        backgroundColor: ColorsUtils.primaryBleu),
                    onPressed: _saveEducation,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ), // Call the save method here
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
