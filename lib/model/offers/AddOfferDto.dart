class AddOfferDto {
  final int companyId;
  final int universityId;
  final String title;
  final String location;
  final String locationType;
  final String description;
  final String salary;
  final String duration;
  final String employmentType;

  AddOfferDto({
    required this.companyId,
    required this.universityId,
    required this.title,
    required this.location,
    required this.locationType,
    required this.description,
    required this.salary,
    required this.duration,
    required this.employmentType,
  });

  factory AddOfferDto.fromJson(Map<String, dynamic> json) {
    return AddOfferDto(
      companyId: json['companyId'] as int,
      universityId: json['universityId'] as int,
      title: json['title'] as String,
      location: json['location'] as String,
      locationType: json['locationType'] as String,
      description: json['description'] as String,
      salary: json['salary'] as String,
      duration: json['duration'] as String,
      employmentType: json['employmentType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'universityId': universityId,
      'title': title,
      'location': location,
      'locationType': locationType,
      'description': description,
      'salary': salary,
      'duration': duration,
      'employmentType': employmentType,
    };
  }
}