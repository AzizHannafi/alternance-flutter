class Experience {
  int? id;
  final String jobTitle;
  final String employmentType;
  final String companyName;
  final String location;
  final String locationType;
  final bool currentlyWorking;
  final DateTime startDate;
  DateTime? endDate;
  final String description;
  final int studentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Experience({
    this.id,
    required this.jobTitle,
    required this.employmentType,
    required this.companyName,
    required this.location,
    required this.locationType,
    required this.currentlyWorking,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      jobTitle: json['jobTitle'],
      employmentType: json['employmentType'],
      companyName: json['companyName'],
      location: json['location'],
      locationType: json['locationType'],
      currentlyWorking: json['currentlyWorking'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      studentId: json['studentId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'employmentType': employmentType,
      'companyName': companyName,
      'location': location,
      'locationType': locationType,
      'currentlyWorking': currentlyWorking,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
      'studentId': studentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
