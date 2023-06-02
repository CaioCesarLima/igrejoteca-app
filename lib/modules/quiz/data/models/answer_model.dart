class AnswerModel {
  final String id;
  final String text;
  final bool correct;

  AnswerModel({required this.id, required this.text, required this.correct});

  factory AnswerModel.fromjson(Map<String, dynamic> json){
    final String id = json['id'];
    final String text = json['text'];
    final bool correct = json['correct'];

    return AnswerModel(id: id, text: text, correct: correct);
  }
}