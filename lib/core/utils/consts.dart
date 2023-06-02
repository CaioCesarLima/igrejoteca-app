import 'package:igrejoteca_app/core/storage/storage.dart';

class Consts {
  static const double khorintalPading = 24;

  static Future<Map<String, String>> authHeader() async {
    String token = await readAccessToken();

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }
}

