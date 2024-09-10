import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Experience {
  final int id;
  final String jobTitle;
  final String employmentType;
  final String companyName;
  final String location;
  final String locationType;
  final bool currentlyWorking;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final int studentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Experience({
    required this.id,
    required this.jobTitle,
    required this.employmentType,
    required this.companyName,
    required this.location,
    required this.locationType,
    required this.currentlyWorking,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
  });
}
