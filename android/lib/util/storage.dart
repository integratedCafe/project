import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorageHelper {
  // Flutter Secure Storage 인스턴스
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 스토리지 저장
  Future<void> set(String key, dynamic value) async {
    String data;

    if (value is Map || value is List) {
      data = jsonEncode(value);
    } else {
      data = value.toString();
    }

    await _storage.write(key: key, value: data);
  }

  // 스토리지 가져옴
  Future<dynamic> get(String key) async {
    String? value = await _storage.read(key: key);

    try {
      return jsonDecode(value);
    } catch (e) {
      return value;
    }
  }

  // 특정 키의 스토리지 삭제
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // 모든 스토리지 삭제
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  // 특정 키가 존재하는지 확인
  Future<bool> contain(String key) async {
    return await _storage.containsKey(key: key);
  }
}
