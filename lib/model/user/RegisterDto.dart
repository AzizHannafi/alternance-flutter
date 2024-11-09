class RegisterDto {
  String email;
  String password;
  String role;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  String? companyName;
  String? companyLocation;
  String? industry;
  String? universityName;
  String? universityLocation;

  RegisterDto({
    required this.email,
    required this.password,
    required this.role,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.companyName,
    this.companyLocation,
    this.industry,
    this.universityName,
    this.universityLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth!.toIso8601String(),
      if (companyName != null) 'companyName': companyName,
      if (companyLocation != null) 'companyLocation': companyLocation,
      if (industry != null) 'industry': industry,
      if (universityName != null) 'universityName': universityName,
      if (universityLocation != null) 'location': universityLocation,
    };
  }
}