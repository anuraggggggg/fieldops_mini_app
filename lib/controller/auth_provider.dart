import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool _isLoading = false;
  bool _obscurePassword = true;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;

  static const String _tokenKey = "auth_token";

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (email == "anurag@fieldops.test" &&
        password == "Test@123") {
      // Save fake token
      await _storage.write(
        key: _tokenKey,
        value: "fieldops_demo_token",
      );

      _isLoading = false;
      notifyListeners();

      return true;
    }

    _isLoading = false;
    notifyListeners();

    return false;
  }

  Future<bool> restoreSession() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null;
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }
}