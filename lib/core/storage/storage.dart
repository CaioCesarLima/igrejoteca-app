import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _kAccessTokenName = 'igrejotecaAccessToken';
const String _kUserDataKeyName = 'igrejotecaUserData';

Future<String> readAccessToken() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  return (await storage.read(key: _kAccessTokenName)) ?? '';
}

Future<void> writeAccessToken(String token) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.write(key: _kAccessTokenName, value: token);
}

Future<void> deleteAccessToken() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.delete(key: _kAccessTokenName);
}


Future<String> readUserData() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  return (await storage.read(key: _kUserDataKeyName)) ?? '';
}

Future<void> writeUserData(String token) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.write(key: _kUserDataKeyName, value: token);
}

Future<void> deleteUserData() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.delete(key: _kUserDataKeyName);
}

Future<void> clearStorageData() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.deleteAll();
}
