import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/modules/reservations/data/models/reservation_model.dart';
import 'package:igrejoteca_app/modules/reservations/data/repositories/reservation_repository.dart';
import 'package:igrejoteca_app/modules/reservations/data/repositories/reservation_repository_impl.dart';
import 'package:igrejoteca_app/modules/reservations/store/bloc/reservation/event/reservation_event.dart';
import 'package:igrejoteca_app/modules/reservations/store/bloc/reservation/state/reservation_state.dart';
import 'package:result_dart/result_dart.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState>{
  final ReservationRepository _reservationRepository = ReservationRepositoryImpl();
  ReservationBloc(): super(EmptyReservationState()){
    on<LoadReservationEvent>(_loadReservation);
  }

  Future<void> _loadReservation(LoadReservationEvent event, Emitter<ReservationState> emit) async{
    emit(LoadingReservationState());
    Result<List<ReservationModel>, Exception> response = await _reservationRepository.loadReservations();

    response.fold((success) {
      success.isEmpty ? emit(EmptyReservationState()) : emit(LoadedReservationState(reserves: success));
    }, (failure) => emit(ErrorLoadReservationState()));
  }
}