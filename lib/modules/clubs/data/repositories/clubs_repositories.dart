
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../../prayers/data/models/testemonie_model.dart';

abstract class ClubsRepositories {
  Future<Result<List<ClubModel>, Exception>> getClubs();
  Future<bool> createClub({required String name, required String bookId, required String ownerId});
  Future<bool> addMember({required String clubId});
}