
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:result_dart/result_dart.dart';

import '../models/rank_model.dart';

abstract class QuizRepository {
  Future<Result<QuestionModel, Exception>>getQuestion();
  Future<void>setScore();
  Future<Result<List<RankModel>, Exception>>getRank();
}