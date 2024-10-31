class UserModel {
  final String username;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'role': role,
    };
  }
}
