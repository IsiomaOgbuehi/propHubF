import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final propHubStorageProvider = Provider.autoDispose((ref) {
  return AppStorage();
});

class AppStorage {
  final storage = const FlutterSecureStorage();

  static const authToken = 'accessToken';
  static const refreshToken = 'refreshToken';
  static const userId = 'userId';
  static const firstname = 'firstname';
  static const lastname = 'lastname';
  static const email = 'email';
  static const phone = 'phone';
  static const userState = 'userState';
  static const userLga = 'userLga';
  static const userType = 'userType';

  Future<void> setAuthToken(String value) async {
    await storage.write(key: authToken, value: value);
  }

  Future<void> setRefreshToken(String value) async {
    await storage.write(key: refreshToken, value: value);
  }

  Future<void> setFirstname(String value) async {
    await storage.write(key: firstname, value: value);
  }

  Future<void> setLastname(String value) async {
    await storage.write(key: lastname, value: value);
  }

  Future<void> setUserId(String value) async {
    await storage.write(key: userId, value: value);
  }

  Future<void> setUserEmail(String value) async {
    await storage.write(key: email, value: value);
  }

  Future<void> setPhone(String value) async {
    await storage.write(key: phone, value: value);
  }

  Future<void> setUserState(String value) async {
    await storage.write(key: userState, value: value);
  }

  Future<void> setUserLga(String value) async {
    await storage.write(key: userLga, value: value);
  }

  Future<void> setUserType(String value) async {
    await storage.write(key: userType, value: value);
  }

  Future<String> getFirstname() async {
    return await storage.read(key: firstname) ?? '';
  }

  Future<String> getAuthTokenVal() async {
    return await storage.read(key: authToken) ?? '';
  }

  Future<String> getRefreshTokenVal() async {
    return await storage.read(key: refreshToken) ?? '';
  }

  Future<String> getUserId() async {
    return await storage.read(key: userId) ?? '';
  }
}