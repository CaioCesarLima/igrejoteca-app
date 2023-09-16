import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/models/rank_model.dart';
import '../../store/bloc/quiz/bloc/quiz_bloc.dart';
import '../../store/bloc/quiz/event/quiz_event.dart';
import '../../store/bloc/quiz/state/quiz_state.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  static const String route = '/quiz/rank';

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  
  late QuizBloc _quizBloc;

  @override
  void initState() {
    super.initState();
    _quizBloc = GetIt.I<QuizBloc>();
    _quizBloc.add(GetRankEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ranking Geral"),
      ),
      body: BlocBuilder(
        bloc: _quizBloc,
        builder: (context, state) {
          if (state is LoadedRankState) {
            
            return ListView.builder(
              itemCount: state.ranks.length,
              itemBuilder: (context, index) {
                RankModel rank = state.ranks[index];
                return ListTile(
                  leading: Text(rank.rank.toString()),
                  title: Text(rank.name),
                  subtitle: Text("Pontos: ${rank.score}"),
                );
              },
            );
          }
          if(state is LoadingQuizState){
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}