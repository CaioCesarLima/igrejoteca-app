
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories.dart';
import 'package:result_dart/src/result.dart';

import '../../../../core/enviroments/enviroment.dart';
import '../../../../core/utils/consts.dart';

class ClubsRepositoriesImpl extends ClubsRepositories{
  @override
  Future<bool> addMember({required String clubId}) async {
    try {
      Uri url = getBackendURL(path: "/api/club/member");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(url, headers: headers, body: {"club_id": clubId});

      if (resp.statusCode == 200) {
        return true;
      }else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> createClub({required String name, required String bookId, required String ownerId}) async {
    try {
      Uri url = getBackendURL(path: "/api/clubs");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(url, headers: headers, body: {"name": name, "book_id": bookId});

      if (resp.statusCode == 201) {
        return true;
      }else {
        return false;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  @override
  Future<Result<List<ClubModel>, Exception>> getClubs() async {
    try {
      Uri url = getBackendURL(path: "/api/clubs");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<ClubModel>clubs = data.map((e) => ClubModel.fromjson(e)).toList();
        return Result.success(clubs);
      }else {
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }
  
}

