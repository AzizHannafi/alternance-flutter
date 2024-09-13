import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/service/experience/ExperienceService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/experience/AddExperience.dart';
import 'package:alternance_flutter/views/experience/ExperienceDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExperienceList extends StatelessWidget {
  final List<Experience> experienceList;
  final Experienceservice _experienceService = Experienceservice();

  ExperienceList({Key? key, required this.experienceList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView.builder(
          itemCount: experienceList.length,
          itemBuilder: (BuildContext context, int index) {
            final experience = experienceList[index];
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
                      // Title taking up 75% of the row
                      Expanded(
                        flex: 3, // 75% width for the title
                        child: Text(
                          experience.jobTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Spacer(),

                      // Icons row for edit and delete
                      Row(
                        mainAxisSize: MainAxisSize
                            .min, // Takes minimal width for the icons
                        children: [
                          // Delete Icon with confirmation
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  context, experience);
                            },
                          ),
                          // Edit Icon
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: ColorsUtils.primaryGreen,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Experiencedetails(
                                  experience: experience,
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
                    '${experience.companyName}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${experience.location} (${experience.locationType})',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'From: ${DateFormat.yMMMd().format(experience.startDate)} To: ${experience.endDate != null ? DateFormat.yMMMd().format(experience.endDate!) : 'Present'}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Type: ${experience.employmentType}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    experience.description,
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

  // Method to show delete confirmation dialog
  void _showDeleteConfirmationDialog(
      BuildContext context, Experience experience) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            'Delete Experience',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this experience entry?',
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
                await _deleteExperience(context, experience.id!);
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

  // Method to delete the experience entry
  Future<void> _deleteExperience(BuildContext context, int experienceId) async {
    try {
      // Call the API to delete the experience entry
      String message = await _experienceService.deleteExperience(experienceId);

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
            'Failed to delete experience entry: $e',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
  }
}
