import 'package:alternance_flutter/model/Company.dart';
import 'package:alternance_flutter/model/University%20.dart';

class Offer {
  final int id;
  final String title;
  final String description;
  final int salary;
  final String duration;
  final int companyId;
  final int universityId;
  final String? employmentType;
  final String? location;
  final String? locationType;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Company company;
  final University university;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.salary,
    required this.duration,
    required this.companyId,
    required this.universityId,
    this.employmentType,
    this.location,
    this.locationType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.university,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      salary: json['salary'] as int,
      duration: json['duration'] as String,
      companyId: json['companyId'] as int,
      universityId: json['universityId'] as int,
      employmentType: json['employmentType'] as String?,
      location: json['location'] as String?,
      locationType: json['locationType'] as String?,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      company: Company.fromJson(json['Company'] as Map<String, dynamic>),
      university:
          University.fromJson(json['University'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'salary': salary,
      'duration': duration,
      'companyId': companyId,
      'universityId': universityId,
      'employmentType': employmentType,
      'location': location,
      'locationType': locationType,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'Company': company.toJson(),
      'University': university.toJson(),
    };
  }
}
