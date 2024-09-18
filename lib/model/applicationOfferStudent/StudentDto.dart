import 'package:alternance_flutter/model/Student.dart';
import 'package:alternance_flutter/model/applicationOfferStudent/Certificate.dart';
import 'package:alternance_flutter/model/applicationOfferStudent/Education.dart';
import 'package:alternance_flutter/model/applicationOfferStudent/Experience.dart';
import 'package:alternance_flutter/model/applicationOfferStudent/User.dart';


class Studentdto extends Student {
  List<Experience> experiences;
  List<Education> educations;
  List<Certificate> certificates;
  User user;

  Studentdto({
    required super.id,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    required super.firstName,
    required super.lastName,
    required super.dateOfBirth,
    required super.headline,
    super.about,
    required this.experiences,
    required this.educations,
    required this.certificates,
    required this.user,
  });

  factory Studentdto.fromJson(Map<String, dynamic> json) {
    return Studentdto(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      headline: json['headline'] ?? '',
      about: json['about'] ?? '',
      experiences: (json['Experiences'] as List<dynamic>?)
          ?.map((exp) => Experience.fromJson(exp))
          .toList() ??
          [],
      educations: (json['Education'] as List<dynamic>?)
          ?.map((edu) => Education.fromJson(edu))
          .toList() ??
          [],
      certificates: (json['Certificates'] as List<dynamic>?)
          ?.map((cert) => Certificate.fromJson(cert))
          .toList() ??
          [],
      user: User.fromJson(json['User'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'headline': headline,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'Experiences': experiences.map((exp) => exp.toJson()).toList(),
      'Education': educations.map((edu) => edu.toJson()).toList(),
      'Certificates': certificates.map((cert) => cert.toJson()).toList(),
      'User': user.toJson(),
    };
  }
}
