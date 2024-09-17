class ApplicationFile {
  int id;
  int applicationId;
  String fileName;
  String filePath;
  String fileType;
  DateTime uploadTimestamp;
  DateTime createdAt;
  DateTime updatedAt;

  ApplicationFile({
    required this.id,
    required this.applicationId,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.uploadTimestamp,
    required this.createdAt,
    required this.updatedAt,
  });

  // fromJson factory constructor
  factory ApplicationFile.fromJson(Map<String, dynamic> json) {
    return ApplicationFile(
      id: json['id'],
      applicationId: json['applicationId'],
      fileName: json['fileName'],
      filePath: json['filePath'],
      fileType: json['fileType'],
      uploadTimestamp: DateTime.parse(json['uploadTimestamp']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'applicationId': applicationId,
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'uploadTimestamp': uploadTimestamp.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
