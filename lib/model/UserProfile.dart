abstract class UserProfile {
  final int id;
  final int userId;
  final String about;
  final String contactInfo;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.userId,
    required this.about,
    required this.contactInfo,
    required this.createdAt,
    required this.updatedAt,
  });
}
