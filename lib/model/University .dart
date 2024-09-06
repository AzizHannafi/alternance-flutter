class University {
  final String universityName;
  final String location;
  final String? about;
  final String? contactInfo;
  final String? socialMedia;
  final String createdAt;
  final String updatedAt;

  University({
    required this.universityName,
    required this.location,
    this.about,
    this.contactInfo,
    this.socialMedia,
    required this.createdAt,
    required this.updatedAt,
  });

  // Manually implemented fromJson method
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      universityName: json['universityName'] as String,
      location: json['location'] as String,
      about: json['about'] as String?,
      contactInfo: json['contactInfo'] as String?,
      socialMedia: json['socialMedia'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  // Manually implemented toJson method
  Map<String, dynamic> toJson() {
    return {
      'universityName': universityName,
      'location': location,
      'about': about,
      'contactInfo': contactInfo,
      'socialMedia': socialMedia,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
