import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/experience/AddExperience.dart';
import 'package:alternance_flutter/views/experience/ExperienceDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExperienceList extends StatelessWidget {
  final List<Experience> experienceList;

  const ExperienceList({Key? key, required this.experienceList})
      : super(key: key);

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
                          experience.jobTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Spacer between the title and the icons
                      Spacer(),

                      // Row for the edit and add icons aligned to the right
                      Row(
                        mainAxisSize: MainAxisSize
                            .min, // Takes minimal width for the icons
                        children: [
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
}
