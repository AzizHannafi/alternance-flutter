import 'package:alternance_flutter/model/user/UserProfile.dart';

class Company extends UserProfile {
  String? companyName;
  String? industry;
  String? location;
  final String? socialMedia;

  String? about; // Nullable
  String? contactInfo;
  Company({
    required int id,
    required int userId,
    this.companyName,
     this.industry,
    this.location,
    this.about,
    this.socialMedia,
    this.contactInfo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
            id: id,
            userId: userId,
            about: about,
            contactInfo: contactInfo,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      companyName: json['companyName'] ?? '',
      industry: json['industry'] ?? '',
      location: json['location'] ?? '',
      about: json['about'] as String?,
      socialMedia: json['socialMedia'] ?? '',
      contactInfo: json['contactInfo'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'about': about,
      'companyName': companyName,
      'industry': industry,
      'location': location,
      'socialMedia': socialMedia,
      'contactInfo': contactInfo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
