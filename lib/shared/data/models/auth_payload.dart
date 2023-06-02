
import 'package:igrejoteca_app/shared/data/models/user_model.dart';

class AuthPayload {
  final String token;
  final UserModel user;

  AuthPayload({required this.token, required this.user});

  factory AuthPayload.fromJson(Map<String, dynamic> json) {
    final String token = json['token'];
    final UserModel user = UserModel.fromJson(json['user']);

    return AuthPayload(token: token, user: user);
  }
}