import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/user_model.dart';
import '../../data/models/user_role.dart';
import 'hash_service.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> registerUser(String username, String email, String password, String namaPanjang, UserRole role) async {
    try {
      final existingUsers = await _firestore.collection('users').where('username', isEqualTo: username).get();
      if (existingUsers.docs.isNotEmpty) return false;

      final salt = HashService.generateSalt();
      final hashedPassword = HashService.hashPassword(password, salt);

      final newUser = UserModel(
        username: username,
        email: email,
        password: hashedPassword,
        salt: salt,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        role: role,
        namaPanjang: namaPanjang,
      );

      final docRef = await _firestore.collection('users').add(newUser.toMap());

      newUser.id = docRef.id;

      await docRef.update({'id': newUser.id});

      return true;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<UserModel?> loginUser(String username, String password) async {
    final snapshot = await _firestore.collection('users').where('username', isEqualTo: username).get();

    if (snapshot.docs.isEmpty) return null;

    final userData = snapshot.docs.first.data();
    final user = UserModel(
      id: snapshot.docs.first.id,
      username: userData['username'],
      email: userData['email'],
      password: userData['password'],
      salt: userData['salt'], // Ambil salt dari data pengguna
      createdAt: (userData['created_at'] as Timestamp).toDate(),
      updatedAt: (userData['updated_at'] as Timestamp).toDate(),
      role: UserRole.values.firstWhere((role) => role.name == userData['role']),
      namaPanjang: userData['nama_panjang'],
    );

    final isValid = HashService.verifyPassword(password, user.password, user.salt);
    return isValid ? user : null;
  }

  Future<UserRole?> getUserRole(String username) async {
    final snapshot = await _firestore.collection('users').where('username', isEqualTo: username).get();
    if (snapshot.docs.isEmpty) return null;

    final userData = snapshot.docs.first.data();
    return UserRole.values.firstWhere((role) => role.name == userData['role']);
  }
}
