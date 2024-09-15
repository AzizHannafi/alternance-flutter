import 'package:alternance_flutter/model/Company.dart';
import 'package:alternance_flutter/model/CompanyDto.dart';

class OfferDto {
  String title;
  CompanyDto company;

  OfferDto({
    required this.title,
    required this.company,
  });

  factory OfferDto.fromJson(Map<String, dynamic> json) {
    return OfferDto(
      title: json['title'] ?? 'Unknown Offer', //
      company: CompanyDto.fromJson(json['Company'] ?? {}),
    );
  }

  // Method to convert this object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'Company': company.toJson(),
    };
  }
}
