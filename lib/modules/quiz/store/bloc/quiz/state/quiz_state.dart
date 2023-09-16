import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';

import '../../../../data/models/rank_model.dart';

abstract class QuizState{}

class LoadingQuizState extends QuizState{}

class LoadedQuizState extends QuizState{
  final QuestionModel question;

  LoadedQuizState(this.question);
}

class CorrectQuizState extends QuizState{}

class EmptyQuizState extends QuizState{}

class LoadedRankState extends QuizState{
  final List<RankModel> ranks;

  LoadedRankState(this.ranks);
}