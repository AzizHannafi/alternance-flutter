class ApplicationFile {
  int id;
  String fileName;
  String filePath;
  String fileType;
  DateTime uploadTimestamp;

  ApplicationFile({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.uploadTimestamp,
  });

  // fromJson factory constructor
  factory ApplicationFile.fromJson(Map<String, dynamic> json) {
    return ApplicationFile(
      id: json['id'],
      fileName: json['fileName'],
      filePath: json['filePath'],
      fileType: json['fileType'],
      uploadTimestamp: DateTime.parse(json['uploadTimestamp']),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'uploadTimestamp': uploadTimestamp.toIso8601String(),
    };
  }
}
