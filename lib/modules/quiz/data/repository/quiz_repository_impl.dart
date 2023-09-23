import 'dart:convert';

import 'package:igrejoteca_app/core/enviroments/enviroment.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository.dart';
import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';

import '../models/rank_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<Result<QuestionModel, Exception>> getQuestion() async {
    try {
      Uri url = getBackendURL(path: "/api/questions/id");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resp.body);
        Map<String, dynamic> data = body['data'];
        QuestionModel question = QuestionModel.fromjson(data);
        return Result.success(question);
      } else {
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }

  @override
  Future<void> setScore() async {
    try {
      Uri url = getBackendURL(path: "/api/question/correct");
      Map<String, String> headers = await Consts.authHeader();

      await http.put(url, headers: headers);
    } catch (_) {}
  }

  @override
  Future<Result<List<RankModel>, Exception>> getRank() async {
    try {
      Uri url = getBackendURL(path: "/api/rank");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<RankModel> ranks = [];
        for (int i = 0; i < data.length; i++) {
          ranks.add(RankModel.fromJson(data[i], i + 1));
        }
        return Result.success(ranks);
      } else {
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }
}
