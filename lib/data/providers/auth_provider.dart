import 'package:aplikasi_baca/common/result_state.dart';
import 'package:aplikasi_baca/common/services/auth_service.dart';
import 'package:aplikasi_baca/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  ResultState _state = ResultState.noData;
  late UserModel _userModel;
  String _message = '';

  ResultState get state => _state;
  UserModel get userModel => _userModel;
  String get message => _message;

  Future<dynamic> login(String username, String password) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final user = await _authService.loginUser(username, password);
      if(user == null) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'User tidak ditemukan';
      } else {
        _state = ResultState.success;
        notifyListeners();

        _userModel = user;
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();

      _message = '$error';
    }
  }
}