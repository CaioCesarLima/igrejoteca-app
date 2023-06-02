import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/modules/login/store/auth_state.dart';
import 'package:igrejoteca_app/modules/quiz/data/models/answer_model.dart';
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository_impl.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/bloc/quiz_bloc.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/event/quiz_event.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/state/quiz_state.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';
import 'package:logger/logger.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  static const String route = "/quiz";

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizBloc _quizBloc;
  late AuthBloc _authBloc;
  bool checkAnswer = false;
  int indexSelected = -1;
  @override
  void initState() {
    super.initState();
    _quizBloc = GetIt.I<QuizBloc>();
    _quizBloc.add(GetQuestionEvent());
    _authBloc = GetIt.I<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, authState) {
        return Scaffold(
            backgroundColor: AppColors.lightBlueColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Quiz"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      const Text("Pontuação: "),
                      authState is UserLoggedState ? Text(authState.user.scoreQuiz.toString()) : const Text("2000") 
                    ],
                  ),
                ),
                
              ],
            ),
            drawer: const CustomDrawer(),
            body: BlocConsumer<QuizBloc, QuizState>(
              bloc: _quizBloc,
              listener: (context, state) {
                if (state is LoadedQuizState) {
                  checkAnswer = false;
                }
                if(state is LoadingQuizState){
                  indexSelected = -1;
                }
              },
              builder: (context, state) {
                if (state is LoadedQuizState) {
                  QuestionModel question = state.question;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: Consts.khorintalPading),
                        child: Center(
                          child: Text(
                            question.text,
                            style: const TextStyle(
                                color: AppColors.accentColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: question.answers.length,
                          itemBuilder: ((context, index) {
                            return AnswerCardWidget(
                              answer: question.answers[index],
                              checkAnswer: checkAnswer,
                              selected: indexSelected == index,
                              onTap: () {
                                if (!checkAnswer) {
                                  setState(() {
                                    indexSelected = index;
                                  });
                                }
                              },
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Consts.khorintalPading, vertical: 20),
                        child: AppButton(
                          label: checkAnswer ? "Próxima" : "Corrigir",
                          backgroundColor: AppColors.primaryColor,
                          ontap: () async {
                            if (checkAnswer) {
                              if(question.answers[indexSelected].correct){
                                (authState as UserLoggedState).user.scoreQuiz += 50;
                                await QuizRepositoryImpl().setScore();
                                Logger().i("acertou");
                              }else{
                                Logger().i("Errou");
                              }
                              _quizBloc.add(GetQuestionEvent());
                              checkAnswer = false;
                            }
                            checkAnswer = true;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  );
                }
                if (state is LoadingQuizState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ));
      },
    );
  }
}

class AnswerCardWidget extends StatelessWidget {
  final AnswerModel answer;
  final bool selected;
  final bool checkAnswer;
  final Function()? onTap;
  const AnswerCardWidget({
    Key? key,
    required this.answer,
    required this.checkAnswer,
    this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Consts.khorintalPading, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: checkAnswer
                  ? answer.correct
                      ? Border.all(color: Colors.green[300]!, width: 5)
                      : Border.all(color: Colors.red[300]!, width: 5)
                  : Border.all(color: Colors.grey[350]!, width: 5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Consts.khorintalPading, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    answer.text,
                    style: const TextStyle(
                        color: AppColors.accentColor, fontSize: 18),
                  ),
                ),
                selected ? const Icon(Icons.check) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
