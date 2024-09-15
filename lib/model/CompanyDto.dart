class CompanyDto {
  String companyName;

  CompanyDto({
    required this.companyName,
  });

  factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      companyName: json['companyName'] ?? 'Unknown Company',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
    };
  }
}
