
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class ClubsRepositories {
  Future<Result<List<ClubModel>, Exception>> getClubs();
  Future<Result<List<ClubModel>, Exception>> getUserClubs();
  Future<Result<List<ClubModel>, Exception>> getBookClubs(String bookId);
  Future<bool> createClub({required String name, required String bookId});
  Future<bool> addMember({required String clubId});
}