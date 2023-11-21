
abstract class AuthEvent {}

class LoginEvent implements AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SingupEvent implements AuthEvent {}

class LogOutEvent implements AuthEvent {}

class CheckUserLogged implements AuthEvent {}


class UpdateScoreUser implements AuthEvent{
  final Map<String, dynamic> userLogged;

  UpdateScoreUser({required this.userLogged});
}
