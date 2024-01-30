import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';

abstract class ClubState{}

class LoadingLoaClubsState extends ClubState{}

class LoadedClubsState extends ClubState{
  final List<ClubModel> clubs;

  LoadedClubsState(this.clubs);
}

class LoadedUserClubsState extends ClubState{
  final List<ClubModel> clubs;

  LoadedUserClubsState(this.clubs);
}

class ErrorClubsState extends ClubState{}

class EmptyClubsState extends ClubState{}
