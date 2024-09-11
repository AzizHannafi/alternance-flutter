import 'UserProfile.dart';

class Student extends UserProfile {
  final String firstName;
  final String lastName;
  final String headline;

  Student({
    required int id,
    required int userId,
    required String about,
    required String contactInfo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.firstName,
    required this.lastName,
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
      id: json['id'],
      userId: json['userId'],
      about: json['about'],
      contactInfo: json['contactInfo'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      headline: json['headline'],
    );
  }
}
