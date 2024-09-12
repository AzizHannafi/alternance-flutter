class Education {
  final int id;
  final String school;
  final String degree;
  final String fieldOfStudy;
  final String location;
  final String locationType;
  final DateTime startDate;
  final DateTime endDate;
  final String grade;
  final String description;
  final int studentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Education({
    required this.id,
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.location,
    required this.locationType,
    required this.startDate,
    required this.endDate,
    required this.grade,
    required this.description,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      school: json['school'],
      degree: json['degree'],
      fieldOfStudy: json['fieldOfStudy'],
      location: json['location'],
      locationType: json['locationType'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      grade: json['grade'],
      description: json['description'],
      studentId: json['studentId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school': school,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'location': location,
      'locationType': locationType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'grade': grade,
      'description': description,
      'studentId': studentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
