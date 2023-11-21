
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository_impl.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/event/quiz_event.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/state/quiz_state.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../data/models/rank_model.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository = QuizRepositoryImpl();
  QuizBloc(): super(EmptyQuizState()){
    on<GetQuestionEvent>(_getQuestion);
    on<GetRankEvent>(_getRankEvent);
    on<IncrementScoreEvent>(_incrementScoreEvent);
  }
  
  Future<void> _getQuestion(GetQuestionEvent event, Emitter emit) async{
    emit(LoadingQuizState());
    Result<QuestionModel, Exception> result = await _quizRepository.getQuestion();
    result.fold((success) => emit(LoadedQuizState(success)), (failure) => emit(EmptyQuizState()));
  }

  Future<void> _getRankEvent(GetRankEvent event, Emitter emit) async {
    emit(LoadingQuizState());
    Result<List<RankModel>, Exception> result = await _quizRepository.getRank();
    result.fold((success) => emit(LoadedRankState(success)),
        (failure) => emit(EmptyQuizState()));
  }

  Future<void> _incrementScoreEvent(IncrementScoreEvent event, Emitter emit) async {
    emit(LoadingQuizState());
    await _quizRepository.setScore();
  }

}