abstract class UserProfile {
  final int id;
  final int userId;
  String? about; // Nullable
  String? contactInfo; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.userId,
    this.about, // Nullable
    this.contactInfo, // Nullable
    required this.createdAt,
    required this.updatedAt,
  });
}
