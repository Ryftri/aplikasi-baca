enum UserRole { pembaca, penulis }

extension UserRoleExtension on UserRole {
  static UserRole? fromString(String role) {
    switch (role) {
      case 'pembaca':
        return UserRole.pembaca;
      case 'penulis':
        return UserRole.penulis;
      default:
        return null;
    }
  }
}
