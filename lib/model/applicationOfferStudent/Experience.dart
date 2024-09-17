class Experience {
  final String jobTitle;

  Experience(this.jobTitle);

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(json['jobTitle'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
    };
  }
}
