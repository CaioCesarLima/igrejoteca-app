import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:igrejoteca_app/modules/emprestimos/data/models/loan_model.dart';

abstract class ClubState{}

class LoadingLoaClubsState extends ClubState{}

class LoadedClubsState extends ClubState{
  final List<ClubModel> clubs;

  LoadedClubsState(this.clubs);
}

class ErrorClubsState extends ClubState{}

class EmptyClubsState extends ClubState{}
