class Education {
  final String degree;

  Education(this.degree);

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(json['degree'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
    };
  }
}