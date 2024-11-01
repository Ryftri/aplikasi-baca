import 'package:aplikasi_baca/data/models/user_role.dart';

class UserModel {
  String? id;
  String username;
  String email;
  String password;
  String salt;
  DateTime createdAt;
  DateTime updatedAt;
  UserRole role;
  String namaPanjang;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.salt, // Tambahkan parameter ini
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.namaPanjang,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'salt': salt, // Sertakan salt dalam map
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role.name,
      'nama_panjang': namaPanjang,
    };
  }
}
