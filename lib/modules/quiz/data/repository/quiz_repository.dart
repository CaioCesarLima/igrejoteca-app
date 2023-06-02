
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:result_dart/result_dart.dart';

abstract class QuizRepository {
  Future<Result<QuestionModel, Exception>>getQuestion();
  Future<void>setScore();
}