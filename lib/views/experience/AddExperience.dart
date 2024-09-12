import 'package:flutter/material.dart';
import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/service/experience/ExperienceService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:intl/intl.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({super.key});

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
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

  final List<String> employmentTypes = ['Onsite', 'Remote', 'Hybrid'];

  @override
  void initState() {
    super.initState();

    jobTitleController = TextEditingController();
    companyNameController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    employmentTypeController = TextEditingController();
    startDate = DateTime.now();
    endDate = DateTime.now();
    selectedEmploymentType = employmentTypes[0]; // Default to the first option
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    employmentTypeController.dispose();
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
      Experience newExperience = Experience(
        currentlyWorking: false,
        studentId: 1, // Update this with the actual student ID
        id: 0, // ID will be generated by the backend
        jobTitle: jobTitleController.text,
        companyName: companyNameController.text,
        location: locationController.text,
        locationType: 'Onsite', // Modify based on your needs
        startDate: startDate,
        endDate: endDate,
        employmentType:
            selectedEmploymentType ?? 'Onsite', // Use selectedEmploymentType
        description: descriptionController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      try {
        // await srv.addExperience(newExperience);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Experience added successfully',
            style: TextStyle(color: ColorsUtils.primaryGreen),
          )),
        );

        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add experience: $e',
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
        title: const Text("Add New Experience",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                            prefixIcon: Icon(Icons.date_range,
                                color: ColorsUtils.primaryGreen, size: 20),
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
                // Employment Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedEmploymentType,
                  items: employmentTypes.map((String type) {
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
                        'Add Experience',
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
