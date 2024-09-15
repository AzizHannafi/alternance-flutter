import 'package:alternance_flutter/model/OfferDto.dart';

class ApplicationDto {
  int id;
  int studentId;
  int offerId;
  DateTime applicationDate;
  String status;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  OfferDto offer;

  ApplicationDto({
    required this.id,
    required this.studentId,
    required this.offerId,
    required this.applicationDate,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.offer,
  });

  factory ApplicationDto.fromJson(Map<String, dynamic> json) {
    return ApplicationDto(
      id: json['id'],
      studentId: json['studentId'],
      offerId: json['offerId'],
      applicationDate: DateTime.parse(json['applicationDate']),
      status: json['status'] ?? 'Pending', // Handle null status
      description: json['description'] ?? '', // Handle null description
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      offer: OfferDto.fromJson(json['Offer'] ?? {}), // Handle null Offer
    );
  }

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
    };
  }
}
