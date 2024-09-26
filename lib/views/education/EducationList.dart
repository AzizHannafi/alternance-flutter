import 'package:alternance_flutter/model/Education.dart';
import 'package:alternance_flutter/service/education/EducationService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/education/EducationDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class EducationList extends StatelessWidget {
  final List<Education> educationList;
  final Educationservice _educationService = Educationservice();
final bool isEditable;
  EducationList({Key? key, required this.educationList,required this.isEditable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView.builder(
          itemCount: educationList.length,
          itemBuilder: (BuildContext context, int index) {
            final education = educationList[index];
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
                          education.school,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      // Icon buttons in a row, aligned to the right
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Delete Icon with a pop-up confirmation
                          Visibility
                            (visible: isEditable,
                              child: IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, education);
                            },
                          )),
                          // Edit Icon
                         Visibility(
                             visible: isEditable,
                             child:  IconButton(
                           icon: const Icon(
                             Icons.edit,
                             color: ColorsUtils.primaryGreen,
                           ),
                           onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => Educationdetails(
                                 education: education,
                               ),
                             ));
                           },
                         )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${education.degree} in ${education.fieldOfStudy}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${education.location} (${education.locationType})',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'From: ${DateFormat.yMMMd().format(education.startDate)} To: ${DateFormat.yMMMd().format(education.endDate)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Grade: ${education.grade}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    education.description,
                    style: Theme.of(context).textTheme.bodyMedium,
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
      BuildContext context, Education education) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            'Delete Education',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this education entry?',
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
                await _deleteEducation(context, education.id!);
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

  // Method to delete the education entry
  Future<void> _deleteEducation(BuildContext context, int educationId) async {
    try {
      // Call the API to delete the education entry
      String message = await _educationService.deleteEducation(educationId);

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
            'Failed to delete education entry: $e',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
  }
}
