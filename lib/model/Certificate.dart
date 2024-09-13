class Certificate {
  int? id;
  final String certificateName;
  final DateTime certificateDate;
  final String organizationName;
  final String certificateLink;
  final String description;
  final int studentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Certificate({
    this.id,
    required this.certificateName,
    required this.certificateDate,
    required this.organizationName,
    required this.certificateLink,
    required this.description,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      certificateName: json['certificateName'],
      certificateDate: DateTime.parse(json['certificateDate']),
      organizationName: json['organizationName'],
      certificateLink: json['certificateLink'],
      description: json['description'],
      studentId: json['studentId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'certificateName': certificateName,
      'organizationName': organizationName,
      'certificateDate': certificateDate.toIso8601String(),
      'certificateLink': certificateLink,
      'description': description,
      'studentId': studentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
