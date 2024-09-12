import 'package:alternance_flutter/model/Certificate.dart';
import 'package:alternance_flutter/service/certificate/CertificateService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Certificatedetails extends StatefulWidget {
  final Certificate certificate;

  Certificatedetails({super.key, required this.certificate});

  @override
  State<Certificatedetails> createState() => _CertificatedetailsState();
}

class _CertificatedetailsState extends State<Certificatedetails> {
  final _formKey = GlobalKey<FormState>();
  Certificateservice srv = Certificateservice();
  late TextEditingController certificateNameController;
  late TextEditingController organizationNameController;
  late TextEditingController certificateLinkController;
  late TextEditingController descriptionController;
  late DateTime certificateDate;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the current values
    certificateNameController =
        TextEditingController(text: widget.certificate.certificateName);
    organizationNameController =
        TextEditingController(text: widget.certificate.organizationName);
    certificateLinkController =
        TextEditingController(text: widget.certificate.certificateLink);
    descriptionController =
        TextEditingController(text: widget.certificate.description);
    certificateDate = widget.certificate.certificateDate;
  }

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    certificateNameController.dispose();
    organizationNameController.dispose();
    certificateLinkController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: certificateDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != certificateDate) {
      setState(() {
        certificateDate = pickedDate;
      });
    }
  }

  Future<void> _saveCertificate() async {
    if (_formKey.currentState!.validate()) {
      // Create updated certificate object
      Certificate updatedCertificate = Certificate(
        id: widget.certificate.id,
        certificateName: certificateNameController.text,
        organizationName: organizationNameController.text,
        certificateDate: certificateDate,
        certificateLink: certificateLinkController.text,
        description: descriptionController.text,
        studentId: widget.certificate.studentId,
        createdAt: widget.certificate.createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        // Call the API to update the certificate details
        await srv.updateCertificate(updatedCertificate);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Certificate details saved successfully',
              style: TextStyle(color: ColorsUtils.primaryGreen),
            ),
          ),
        );

        // Navigate back or perform other actions
        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to save certificate details: $e',
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
        title: const Text("Edit Certificate Details",
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
                // Certificate Name
                TextFormField(
                  controller: certificateNameController,
                  decoration: const InputDecoration(
                    labelText: "Certificate Name",
                    hintText: 'Enter certificate name',
                    prefixIcon: Icon(Icons.card_membership,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the certificate name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Organization Name
                TextFormField(
                  controller: organizationNameController,
                  decoration: const InputDecoration(
                    labelText: "Organization Name",
                    prefixIcon: Icon(Icons.business,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the organization name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Certificate Date
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Certificate Date",
                      prefixIcon: Icon(Icons.date_range,
                          color: ColorsUtils.primaryGreen, size: 20),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                      ),
                    ),
                    child: Text(DateFormat.yMMMd().format(certificateDate)),
                  ),
                ),
                const SizedBox(height: 15),
                // Certificate Link
                TextFormField(
                  controller: certificateLinkController,
                  decoration: const InputDecoration(
                    labelText: "Certificate Link",
                    prefixIcon: Icon(Icons.link,
                        color: ColorsUtils.primaryGreen, size: 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsUtils.primaryGreen),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the certificate link';
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
                    onPressed: _saveCertificate,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
