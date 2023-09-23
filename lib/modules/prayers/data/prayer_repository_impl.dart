import 'dart:convert';

import 'package:igrejoteca_app/core/enviroments/enviroment.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:http/http.dart' as http;
import 'package:igrejoteca_app/modules/prayers/data/models/prayer_model.dart';
import 'package:igrejoteca_app/modules/prayers/data/prayer_repository.dart';
import 'package:result_dart/result_dart.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  @override
  Future<Result<List<PrayerModel>, Exception>> getUserPrayers() async {
    try {
      Uri url = getBackendURL(path: "/api/prayer");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<PrayerModel> prayers =
            data.map((e) => PrayerModel.fromjson(e)).toList().reversed.toList();
        return Result.success(prayers);
      } else {
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }

  @override
  Future<Result<List<PrayerModel>, Exception>> getAllPrayers() async {
    try {
      Uri url = getBackendURL(path: "/api/prayers-all");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<PrayerModel> prayers =
            data.map((e) => PrayerModel.fromjson(e)).toList().reversed.toList();
        return Result.success(prayers);
      } else {
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }

  @override
  Future<bool> createPrayers({required String description,required bool isAnonymous}) async {
    
    try {
      Uri url = getBackendURL(path: "/api/prayer");

      Map<String, String> headers = await Consts.authHeader();
      Map<String, dynamic> body = {
        "description": description,
        "is_anonymous": isAnonymous
      };
      http.Response resp = await http.post(url, body: jsonEncode(body), headers: headers);

      if (resp.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
    }

    return false;
  }
}
