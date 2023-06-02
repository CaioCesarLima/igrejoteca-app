
import 'package:igrejoteca_app/modules/reservations/data/models/reservation_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class ReservationRepository {
  Future<Result<List<ReservationModel>, Exception>> loadReservations();
}