
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository_impl.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/event/quiz_event.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/state/quiz_state.dart';
import 'package:result_dart/result_dart.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository = QuizRepositoryImpl();
  QuizBloc(): super(EmptyQuizState()){
    on<GetQuestionEvent>(_getQuestion);
  }
  
  Future<void> _getQuestion(GetQuestionEvent event, Emitter emit) async{
    emit(LoadingQuizState());
    Result<QuestionModel, Exception> result = await _quizRepository.getQuestion();
    result.fold((success) => emit(LoadedQuizState(success)), (failure) => emit(EmptyQuizState()));
  }
}