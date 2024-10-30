class UserModel {
  final String username;
  final String email;
  final String password; // Pastikan untuk mengamankan data ini
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
