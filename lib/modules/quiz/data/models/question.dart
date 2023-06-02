import 'package:igrejoteca_app/modules/quiz/data/models/answer_model.dart';

class QuestionModel {
  final String id;
  final String text;
  final List<AnswerModel> answers;

  QuestionModel({required this.id, required this.text, required this.answers});


  factory QuestionModel.fromjson(Map<String, dynamic> json){
    final String id = json['id'];
    final String text = json['text'];
    final List<AnswerModel> answers = (json['answers'] as List).map((answer) => AnswerModel.fromjson(answer['data'])).toList();

    return QuestionModel(id: id, text: text, answers: answers);
  }
}