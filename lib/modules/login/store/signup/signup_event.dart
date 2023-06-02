abstract class SignupEvent {}

class SignupDoEvent implements SignupEvent {
  final String email;
  final String password;
  final String name;

  SignupDoEvent({required this.name, required this.email, required this.password});
}
