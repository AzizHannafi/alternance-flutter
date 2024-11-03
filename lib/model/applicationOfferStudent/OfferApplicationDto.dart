import 'package:alternance_flutter/model/offers/Offer.dart';
import '../Company.dart';
import '../University .dart';

class Offerapplicationdto {
  String title;            // Declare class members
  University university;

  // Proper constructor initialization
  Offerapplicationdto({
    required this.title,
    required this.university,
  });

  // Factory method for constructing object from JSON
  factory Offerapplicationdto.fromJson(Map<String, dynamic> json) {
    return Offerapplicationdto(
      title: json['title'] as String,
      university: University.fromJson(json['University'] as Map<String, dynamic>),
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'University': university.toJson(),
    };
  }
}
