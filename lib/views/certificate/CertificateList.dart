import 'package:alternance_flutter/model/Certificate.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/certificate/CertificateDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class CertificateList extends StatelessWidget {
  final List<Certificate> certificateList;

  const CertificateList({Key? key, required this.certificateList})
      : super(key: key);

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
                border: Border.all(
                    color: ColorsUtils
                        .primaryGreen), // Use your ColorsUtils.primaryBleu
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Title taking up 75% of the row
                      Expanded(
                        flex: 3, // 75% width for the title
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

                      // Spacer between the title and the edit icon
                      Spacer(),

                      // Edit Icon in a row, aligned to the right
                      Row(
                        mainAxisSize: MainAxisSize
                            .min, // Takes minimal width required by the icon
                        children: [
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
}
