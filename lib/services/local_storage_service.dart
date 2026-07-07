import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  StorageService._();

  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static const String tokenKey = "token";
  static const String jobsKey = "jobs";
  static const String notesKey = "notes";

  static Future<void> write(
      String key,
      dynamic value,
      ) async {
    await _storage.write(
      key: key,
      value: jsonEncode(value),
    );
  }

  static Future<dynamic> read(String key) async {
    final value = await _storage.read(key: key);

    if (value == null) return null;

    return jsonDecode(value);
  }

  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}