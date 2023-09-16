
import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/quiz/UI/pages/quiz_page.dart';

import '../UI/pages/rank_page.dart';

class QuizRoutes {
  static const String quiz = QuizPage.route;
  static const String rank = RankPage.route;

  static final Map<String, WidgetBuilder> routes = {
    quiz: (context) => const QuizPage(),
    rank: (context) => const RankPage(),
  };
}