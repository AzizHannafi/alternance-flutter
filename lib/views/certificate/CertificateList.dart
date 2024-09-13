import 'package:alternance_flutter/model/Certificate.dart';
import 'package:alternance_flutter/service/certificate/CertificateService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/certificate/CertificateDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class CertificateList extends StatelessWidget {
  final List<Certificate> certificateList;
  final Certificateservice _certificateService = Certificateservice();

  CertificateList({Key? key, required this.certificateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView.builder(
          itemCount: certificateList.length,
          itemBuilder: (BuildContext context, int index) {
            final certificate = certificateList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsUtils.primaryGreen),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          certificate.certificateName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Delete Icon with a pop-up confirmation
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  context, certificate);
                            },
                          ),
                          // Edit Icon
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: ColorsUtils.primaryGreen,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Certificatedetails(
                                  certificate: certificate,
                                ),
                              ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Organization: ${certificate.organizationName}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date: ${DateFormat.yMMMd().format(certificate.certificateDate)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    certificate.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Link: ${certificate.certificateLink}',
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to show the delete confirmation dialog
  void _showDeleteConfirmationDialog(
      BuildContext context, Certificate certificate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Delete Certificate',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this certificate entry?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: ColorsUtils.primaryGreen),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // Call the delete function when confirmed
                await _deleteCertificate(context, certificate.id!);
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to delete the certificate entry
  Future<void> _deleteCertificate(
      BuildContext context, int certificateId) async {
    try {
      // Call the API to delete the certificate entry
      String message =
          await _certificateService.deleteCertificate(certificateId);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: ColorsUtils.primaryGreen),
          ),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to delete certificate entry: $e',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
  }
}
