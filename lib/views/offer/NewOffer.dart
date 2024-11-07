import 'package:alternance_flutter/service/univesrsity/UniversityService.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/service/offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';

import '../../model/offers/AddOfferDto.dart';

class NewOffer extends StatefulWidget {
  final int companyId;
    NewOffer({Key? key, required this.companyId}) : super(key: key);

  @override
  State<NewOffer> createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  final _formKey = GlobalKey<FormState>();
  OfferService srv = OfferService();
  UniversityService universityService = UniversityService();
  late Future<Map<int, String>> _futureUniversitiesMap;
  Map<int, String> universities = {};


  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController salaryController;
  late TextEditingController durationController;
  late TextEditingController descriptionController;
  String? selectedLocationType;
  String? selectedEmploymentType;
  int? selectedUniversityId;


  final List<String> locationType = ['On site', 'Remote', 'Hybrid'];
  final List<String> employmentType = ['Full time', 'Part time', 'Freelance'];

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    locationController = TextEditingController();
    salaryController = TextEditingController();
    durationController = TextEditingController();
    descriptionController = TextEditingController();
    selectedLocationType = locationType[0];
    selectedEmploymentType = employmentType[0];
    _futureUniversitiesMap = _fetchUniversityMap();
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    salaryController.dispose();
    durationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveOffer() async {
    if (_formKey.currentState!.validate() && selectedUniversityId != null) {
      AddOfferDto newOffer = AddOfferDto(
        companyId: widget.companyId,
        universityId:  selectedUniversityId!,
        title: titleController.text,
        employmentType: selectedEmploymentType!.toLowerCase(),
        location: locationController.text,
        locationType: selectedLocationType!.toLowerCase(),
        salary: salaryController.text,
        duration: durationController.text,
        description: descriptionController.text,
      );

      try {
        await srv.addOffer(newOffer);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Offer added successfully',
              style: TextStyle(color: ColorsUtils.primaryGreen),
            ),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        print('error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add offer: $e',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        );
      }
    }
  }
  Future<Map<int, String>> _fetchUniversityMap() async {
    try {
      universities = await universityService.fetchUniversityMap();
      return universities;
    } catch (e) {
      print('Failed to load universities: $e');
      return {}; // Return an empty map in case of error
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Offer",
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
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Job Title",
                    hintText: 'Enter Job Title',
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
                FutureBuilder<Map<int, String>>(
                  future: _futureUniversitiesMap,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show a loading indicator
                    } else if (snapshot.hasError) {
                      return Text("Failed to load universities");
                    } else {
                      universities = snapshot.data ?? {}; // Assign data if available
                      return DropdownButtonFormField<int>(
                        value: selectedUniversityId,
                        items: universities.entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedUniversityId = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "University",
                          prefixIcon: Icon(Icons.school,
                              color: ColorsUtils.primaryGreen, size: 20),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a university';
                          }
                          return null;
                        },
                      );
                    }
                  },
                ),

                const SizedBox(height: 15),
                TextFormField(
                  controller: salaryController,
                  decoration: const InputDecoration(
                    labelText: "Salary",
                    prefixIcon: Icon(Icons.monetization_on,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the salary';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: "Duration",
                    prefixIcon: Icon(Icons.timer,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: ColorsUtils.primaryBleu,
                    ),
                    onPressed: _saveOffer,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Add Offer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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