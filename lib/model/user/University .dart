import 'UserProfile.dart';

class University extends UserProfile{
  String? universityName;
   String? location;
  String? about;
  String? contactInfo;
  final String? socialMedia;

  University({
    required int id,
    required int userId,
    required this.universityName,
    required this.location,
    this.about,
    this.contactInfo,
    this.socialMedia,
    required DateTime createdAt,
    required DateTime updatedAt,
  }): super(
      id: id,
      userId: userId,
      about: about,
      contactInfo: contactInfo,
      createdAt: createdAt,
      updatedAt: updatedAt);

  // Manually implemented fromJson method
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      universityName: json['universityName'] as String,
      location: json['location'] as String,
      about: json['about'] as String?,
      contactInfo: json['contactInfo'] as String?,
      socialMedia: json['socialMedia'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Manually implemented toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'universityName': universityName,
      'location': location,
      'about': about,
      'contactInfo': contactInfo,
      'socialMedia': socialMedia,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
