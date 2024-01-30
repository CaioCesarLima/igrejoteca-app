import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories_impl.dart';
import 'package:igrejoteca_app/modules/clubs/store/event/clubs_event.dart';
import 'package:igrejoteca_app/modules/clubs/store/state/clubs_state.dart';
import 'package:result_dart/result_dart.dart';

class ClubBloc extends Bloc<ClubEvent, ClubState> {
  ClubsRepositories clubRepository = ClubsRepositoriesImpl();
  ClubBloc() : super(EmptyClubsState()) {
    on<GetClubsEvent>(_getClubs);
    on<GetUserClubsEvent>(_getUserClubs);
    on<GetBookClubsEvent>(_getBookClubs);
  }

  Future<void> _getClubs(GetClubsEvent event, Emitter emit) async {
    emit(LoadingLoaClubsState());
    Result<List<ClubModel>, Exception> result = await clubRepository.getClubs();
    result.fold((success) {
      if (success.isEmpty) {
        emit(EmptyClubsState());
      } else {
        emit(LoadedClubsState(success));
      }
    }, (failure) => emit(ErrorClubsState()));
  }

  Future<void> _getUserClubs(GetUserClubsEvent event, Emitter emit) async {
    emit(LoadingLoaClubsState());
    Result<List<ClubModel>, Exception> result = await clubRepository.getUserClubs();
    result.fold((success) {

      if (success.isEmpty) {
        emit(EmptyClubsState());
      } else {
        emit(LoadedUserClubsState(success));
      }
    }, (failure) => emit(ErrorClubsState()));
  }

  Future<void> _getBookClubs(GetBookClubsEvent event, Emitter emit) async {
    emit(LoadingLoaClubsState());
    Result<List<ClubModel>, Exception> result = await clubRepository.getBookClubs(event.bookId);
    result.fold((success) {
      
      if (success.isEmpty) {
        emit(EmptyClubsState());
      } else {
        emit(LoadedUserClubsState(success));
      }
    }, (failure) => emit(ErrorClubsState()));
  }
}
