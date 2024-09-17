import 'package:alternance_flutter/model/applicationOfferStudent/StudentDto.dart';
import 'ApplicationFile.dart';
import 'OfferApplicationDto.dart';

class Application {
  int? id;
  int? studentId;
  int? offerId;
  DateTime applicationDate;
  String status;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  Offerapplicationdto offer;
  Studentdto student;
  List<ApplicationFile> applicationFiles;

  Application({
     this.id,
     this.studentId,
     this.offerId,
    required this.applicationDate,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.offer,
    required this.student,
    required this.applicationFiles,
  });

  // fromJson factory constructor
  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      studentId: json['studentId'],
      offerId: json['offerId'],
      applicationDate: DateTime.parse(json['applicationDate']),
      status: json['status'],
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      offer: Offerapplicationdto.fromJson(json['Offer']),
      student: Studentdto.fromJson(json['Student']),
      applicationFiles: (json['ApplicationFiles'] as List<dynamic>)
          .map((file) => ApplicationFile.fromJson(file))
          .toList(),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'offerId': offerId,
      'applicationDate': applicationDate.toIso8601String(),
      'status': status,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'Offer': offer.toJson(),
      'Student': student.toJson(),
      'ApplicationFiles': applicationFiles.map((file) => file.toJson()).toList(),
    };
  }
}
