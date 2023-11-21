

import 'package:igrejoteca_app/shared/data/models/user_model.dart';

abstract class AuthState {}

class UserLoggedState implements AuthState {
  final String token;
  final UserModel user;

  UserLoggedState({required this.token, required this.user});
}

class LoadingAuthState implements AuthState {}

class LoadingScoreAuthState implements AuthState {}

class ErrorAuthState implements AuthState {}

class LogoutAuthState implements AuthState {}

class InitialAuthState implements AuthState {}


