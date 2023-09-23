
import 'dart:convert';

import 'package:igrejoteca_app/core/enviroments/enviroment.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/reservations/data/models/reservation_model.dart';
import 'package:igrejoteca_app/modules/reservations/data/repositories/reservation_repository.dart';
import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';

class ReservationRepositoryImpl implements ReservationRepository{
  @override
  Future<Result<List<ReservationModel>, Exception>> loadReservations() async {
    try {
      Uri url = getBackendURL(path: "/api/reserve-user");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<ReservationModel>reserves = data.map((e) => ReservationModel.fromjson(e)).toList();
        return Result.success(reserves);
      }else {
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }
  
}