import 'dart:convert';

class UserModel{
  final String email;
  final String id;
  final String name;
  int scoreQuiz;

  UserModel({required this.email, required this.id, required this.name, required this.scoreQuiz});

  factory UserModel.fromJson(Map<String, dynamic> json) {

    final String email = json['email'];
    final String id = json['id'];
    final String name = json['name'];
    final int scoreQuiz = json['score_quiz'] ?? 0;

    return UserModel(email: email, id: id, name: name, scoreQuiz: scoreQuiz);
  }

  String encodeB64() {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'email': email,
      'score_quiz': scoreQuiz
    };

    List<int> dataString = utf8.encode(jsonEncode(data));

    return base64.encode(dataString);
  }
}