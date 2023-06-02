import 'package:igrejoteca_app/modules/prayers/data/models/prayer_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class PrayerRepository {
  Future<Result<List<PrayerModel>, Exception>> getUserPrayers();
  Future<Result<List<PrayerModel>, Exception>> getAllPrayers();
  Future<bool> createPrayers({required String description,required bool isAnonymous});
}