import "dart:async";
import "dart:convert";

import "package:flutter_secure_storage/flutter_secure_storage.dart";

class StorageService {
  factory StorageService() {
    return I;
  }

  final String authTokenStoreKey = "AuthToken";
  final String loginDataStoreKey = "LoginData";
  final String profileImagePath = "ProfileImagePath";
  final String loginExpireTime = "LoginExpire";

  StorageService._();

  static final StorageService I = StorageService._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<void> storeData({required String key, required data}) async {
    await _storage.write(key: key, value: jsonEncode(data));
  }

  Future readData({required String key}) async {
    final String? data = await _storage.read(key: key);
    if (data != null) {
      try {
        return jsonDecode(data);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future deleteData({required String key}) async {
    await _storage.delete(key: key);
  }
}
