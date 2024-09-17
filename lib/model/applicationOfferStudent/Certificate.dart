class Certificate {
  final String certificateName;

  Certificate(this.certificateName);

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(json['certificateName'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'certificateName': certificateName,
    };
  }
}