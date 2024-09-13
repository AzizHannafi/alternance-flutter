import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/service/experience/ExperienceService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Experiencedetails extends StatefulWidget {
  Experience experience;
  Experiencedetails({super.key, required this.experience});

  @override
  State<Experiencedetails> createState() => _ExperiencedetailsState();
}

class _ExperiencedetailsState extends State<Experiencedetails> {
  final _formKey = GlobalKey<FormState>();
  Experienceservice srv = Experienceservice();
  late TextEditingController jobTitleController;
  late TextEditingController companyNameController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController employmentTypeController;
  late DateTime startDate;
  late DateTime endDate;
  String? selectedEmploymentType;
  bool isCurrentlyWorking = false; // For the checkbox
  String? selectedLocationType;

  final List<String> employmentType = ['Full time', 'Half time', 'Freelance'];
  final List<String> locationType = ['On site', 'Remote', 'Hybrid'];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the current values
    jobTitleController =
        TextEditingController(text: widget.experience.jobTitle);
    companyNameController =
        TextEditingController(text: widget.experience.companyName);
    locationController =
        TextEditingController(text: widget.experience.location);
    employmentTypeController =
        TextEditingController(text: widget.experience.employmentType);
    descriptionController =
        TextEditingController(text: widget.experience.description);
    startDate = widget.experience.startDate;
    endDate = widget.experience.endDate ?? DateTime.now();
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    locationController.dispose();
    employmentTypeController.dispose();
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

  Future<void> _saveExperience() async {
    if (_formKey.currentState!.validate()) {
      // Create updated experience object
      Experience updatedExperience = Experience(
        currentlyWorking: widget.experience.currentlyWorking,
        studentId: widget.experience.studentId,
        id: widget.experience.id,
        jobTitle: jobTitleController.text,
        companyName: companyNameController.text,
        location: locationController.text,
        locationType: widget.experience.locationType.toLowerCase(),
        startDate: startDate,
        endDate: endDate,
        employmentType: employmentTypeController.text.toLowerCase(),
        description: descriptionController.text,
        createdAt: widget.experience.createdAt,
        updatedAt: DateTime.now(), // Update the updatedAt field
      );

      try {
        // Call the API to update the experience details
        await srv.updateExperience(updatedExperience);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Experience details saved successfully',
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
              'Failed to save experience details: $e',
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
        title: const Text("Edit Experience Details",
            style: TextStyle(fontWeight: FontWeight.bold)),
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
                // Job Title
                TextFormField(
                  controller: jobTitleController,
                  decoration: const InputDecoration(
                    labelText: "Job Title",
                    hintText: 'Enter your Job Title',
                    prefixIcon: Icon(Icons.work,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the job title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Employment Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedEmploymentType,
                  items: employmentType.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEmploymentType = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Employment Type",
                    prefixIcon: Icon(Icons.category,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Company Name
                TextFormField(
                  controller: companyNameController,
                  decoration: const InputDecoration(
                    labelText: "Company Name",
                    prefixIcon: Icon(Icons.business,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the company name';
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

                // "Currently Working" Checkbox
                CheckboxListTile(
                  title: const Text('I am currently working here'),
                  value: isCurrentlyWorking,
                  onChanged: (bool? value) {
                    setState(() {
                      isCurrentlyWorking = value ?? false;
                      if (isCurrentlyWorking) {
                        endDate = DateTime
                            .now(); // Set end date to null if currently working
                      } else {
                        endDate = DateTime
                            .now(); // Set default end date if not currently working
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: ColorsUtils.primaryGreen,
                ),
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
                        onTap: isCurrentlyWorking
                            ? null
                            : () => _selectDate(context, false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: "End Date",
                            prefixIcon: Icon(Icons.date_range,
                                color: ColorsUtils.primaryGreen, size: 20),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsUtils.primaryGreen),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            isCurrentlyWorking
                                ? 'Present'
                                : DateFormat.yMMMd()
                                    .format(endDate ?? DateTime.now()),
                            style: TextStyle(
                              color: isCurrentlyWorking ? Colors.grey : null,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                // Location Type
                DropdownButtonFormField<String>(
                  value: selectedLocationType,
                  items: locationType.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocationType = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Location Type",
                    prefixIcon: Icon(Icons.category,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
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
                    onPressed: _saveExperience,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
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
