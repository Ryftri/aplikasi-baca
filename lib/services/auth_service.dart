import '../data/models/user_model.dart';
import 'hash_service.dart';

class AuthService {
  final List<UserModel> _users = [];

  bool registerUser(String username, String email, String password, String role) {
    if (_users.any((user) => user.username == username)) return false;

    final salt = HashService.generateSalt();
    final hashedPassword = HashService.hashPassword(password, salt);

    final newUser = UserModel(
      username: username,
      email: email,
      password: hashedPassword,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      role: role,
    );

    _users.add(newUser);
    print(newUser.toMap());
    return true;
  }

  bool loginUser(String username, String password) {
    final user = _users.firstWhere(
          (user) => user.username == username,
      orElse: () => UserModel(
        username: '',
        email: '',
        password: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        role: '',
      ),
    );

    if (user.username.isEmpty) return false;
    return HashService.verifyPassword(password, user.password, user.username);
  }

  String? getUserRole(String username) {
    final user = _users.firstWhere(
          (user) => user.username == username,
      orElse: () => UserModel(
        username: '',
        email: '',
        password: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        role: '',
      ),
    );
    return user.username.isNotEmpty ? user.role : null;
  }
}
