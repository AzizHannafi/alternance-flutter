import 'package:alternance_flutter/model/offers/Offer.dart';
import 'package:alternance_flutter/service/univesrsity/UniversityService.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/service/offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';

import '../../model/offers/AddOfferDto.dart';
import '../../utils/SharedPreferencesUtils.dart';

class EditOffer extends StatefulWidget {
  final Offer offer;

  EditOffer({Key? key, required this.offer}) : super(key: key);

  @override
  State<EditOffer> createState() => _EditOfferState();
}

class _EditOfferState extends State<EditOffer> {
  final _formKey = GlobalKey<FormState>();
  final OfferService srv = OfferService();
  final UniversityService universityService = UniversityService();
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
  String? appToken;
  final List<String> locationType = ['On site', 'Remote', 'Hybrid'];
  final List<String> employmentType = ['Full time', 'Part time', 'Freelance'];

  Future<void> _initializePreferences() async {
    await SharedPreferencesUtils.init();
    appToken = SharedPreferencesUtils.getValue<String>("appToken");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();

    titleController = TextEditingController(text: widget.offer.title);
    locationController = TextEditingController(text: widget.offer.location);
    salaryController = TextEditingController(text: widget.offer.salary.toString());
    durationController = TextEditingController(text: widget.offer.duration);
    descriptionController = TextEditingController(text: widget.offer.description);

    selectedLocationType = locationType.firstWhere(
          (type) => type.toLowerCase() == widget.offer.locationType?.toLowerCase(),
      orElse: () => locationType[0],
    );
    selectedEmploymentType = employmentType.firstWhere(
          (type) => type.toLowerCase() == widget.offer.employmentType?.toLowerCase(),
      orElse: () => employmentType[0],
    );

    selectedUniversityId = widget.offer.university.id;
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

  Future<void> _updateOffer() async {
    if (_formKey.currentState!.validate() && selectedUniversityId != null) {
      AddOfferDto newOffer = AddOfferDto(
        companyId: widget.offer.companyId,
        universityId: selectedUniversityId!,
        title: titleController.text,
        employmentType: selectedEmploymentType!.toLowerCase(),
        location: locationController.text,
        locationType: selectedLocationType!.toLowerCase(),
        salary: salaryController.text,
        duration: durationController.text,
        description: descriptionController.text,
      );

      if (appToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: No authentication token found.',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        );
        return;
      }

      try {
        await srv.updateOffer(widget.offer.id, newOffer, appToken!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Offer updated successfully',
              style: TextStyle(color: ColorsUtils.primaryGreen),
            ),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update offer: $e',
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
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Offer", style: TextStyle(fontWeight: FontWeight.bold)),
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
                _buildTextField("Job Title", titleController, Icons.work, "Please enter the job title"),
                const SizedBox(height: 15),
                _buildDropdownField("Employment Type", employmentType, selectedEmploymentType, (value) {
                  setState(() {
                    selectedEmploymentType = value;
                  });
                }, Icons.category),
                const SizedBox(height: 15),
                _buildTextField("Location", locationController, Icons.location_on, "Please enter the location"),
                const SizedBox(height: 15),
                _buildDropdownField("Location Type", locationType, selectedLocationType, (value) {
                  setState(() {
                    selectedLocationType = value;
                  });
                }, Icons.category),
                const SizedBox(height: 15),
                _buildUniversityDropdown(),
                const SizedBox(height: 15),
                _buildTextField("Salary", salaryController, Icons.monetization_on, "Please enter the salary"),
                const SizedBox(height: 15),
                _buildTextField("Duration", durationController, Icons.access_time, "Please enter the duration"),
                const SizedBox(height: 15),
                _buildTextField("Description", descriptionController, Icons.description, "Please enter the description", maxLines: 3),
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
                    onPressed: _updateOffer,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Edit Offer',
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

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, String validationMessage, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: ColorsUtils.primaryGreen, size: 20),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsUtils.primaryGreen),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? selectedValue, ValueChanged<String?> onChanged, IconData icon) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: ColorsUtils.primaryGreen, size: 20),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsUtils.primaryGreen),
        ),
      ),
    );
  }

  Widget _buildUniversityDropdown() {
    return FutureBuilder<Map<int, String>>(
      future: _futureUniversitiesMap,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("Failed to load universities");
        } else {
          universities = snapshot.data ?? {};

          if (selectedUniversityId != null && !universities.containsKey(selectedUniversityId)) {
            selectedUniversityId = null;
          }

          return DropdownButtonFormField<int>(
            value: selectedUniversityId,
            items: universities.entries.map((entry) => DropdownMenuItem(value: entry.key, child: Text(entry.value))).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedUniversityId = newValue;
              });
            },
            decoration: const InputDecoration(
              labelText: "University",
              prefixIcon: Icon(Icons.school, color: ColorsUtils.primaryGreen, size: 20),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsUtils.primaryGreen),
              ),
            ),
            validator: (value) => value == null ? 'Please select a university' : null,
          );
        }
      },
    );
  }
}
