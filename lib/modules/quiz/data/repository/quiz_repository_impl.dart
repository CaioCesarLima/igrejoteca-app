
import 'dart:convert';

import 'package:igrejoteca_app/core/enviroments/enviroment.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/quiz/data/models/question.dart';
import 'package:igrejoteca_app/modules/quiz/data/repository/quiz_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<Result<QuestionModel, Exception>> getQuestion() async {
    try {
      Uri url = getBackendURL(path: "/api/questions/id");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      Logger().d(resp.body);

      if (resp.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resp.body);
        Map<String, dynamic> data = body['data'];
        QuestionModel question = QuestionModel.fromjson(data);
        return Result.success(question);
      }else {
        Logger().i(resp.statusCode);
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
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

    } catch (e) {
      Logger().d(e.toString());
    }

  }
  
}