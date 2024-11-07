
import 'UserProfile.dart';

class Student extends UserProfile {
  String firstName;
  String lastName;
  String dateOfBirth;
  String headline;
  String? about; // Nullable
  String? contactInfo; // Nullable

  Student({
    required int id,
    required int userId,
    this.about, // Nullable
    this.contactInfo, // Nullable
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.headline,
  }) : super(
          id: id,
          userId: userId,
          about: about,
          contactInfo: contactInfo,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0, // Provide a default value if null
      userId: json['userId'] ?? 0, // Provide a default value if null
      about: json['about'] as String?, // Nullable
      contactInfo: json['contactInfo'] as String?, // Nullable
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      firstName: json['firstName'] ?? '', // Provide a default value if null
      lastName: json['lastName'] ?? '', // Provide a default value if null
      dateOfBirth: json['dateOfBirth'] ?? '', // Provide a default value if null
      headline: json['headline'] ?? '', // Provide a default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'about': about,
      'contactInfo': contactInfo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'headline': headline,
    };
  }
}
