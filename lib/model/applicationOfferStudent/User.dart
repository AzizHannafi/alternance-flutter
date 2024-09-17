class User {
  final String username;

  User(this.username);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['userName'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': username,
    };
  }
}