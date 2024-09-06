class Company {
  final String companyName;
  final String industry;
  final String? location;
  final String? about;
  final String? socialMedia;
  final String? contactInfo;
  final String createdAt;
  final String updatedAt;

  Company({
    required this.companyName,
    required this.industry,
    this.location,
    this.about,
    this.socialMedia,
    this.contactInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['companyName'],
      industry: json['industry'],
      location: json['location'],
      about: json['about'],
      socialMedia: json['socialMedia'],
      contactInfo: json['contactInfo'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'industry': industry,
      'location': location,
      'about': about,
      'socialMedia': socialMedia,
      'contactInfo': contactInfo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
