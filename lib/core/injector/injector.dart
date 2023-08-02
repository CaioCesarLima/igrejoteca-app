import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/modules/books/store/bloc/book/bloc/book_bloc.dart';
import 'package:igrejoteca_app/modules/emprestimos/store/bloc/loan/bloc/loan_bloc.dart';
import 'package:igrejoteca_app/modules/login/store/atoms/sigunp_reducers.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/bloc/loan_bloc.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/testemony/bloc/testemony_bloc.dart';
import 'package:igrejoteca_app/modules/quiz/store/bloc/quiz/bloc/quiz_bloc.dart';
import 'package:igrejoteca_app/modules/reservations/store/bloc/reservation/bloc/reservation_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());
  locator.registerLazySingleton<BookBloc>(() => BookBloc());
  locator.registerLazySingleton<ReservationBloc>(() => ReservationBloc());
  locator.registerLazySingleton<LoanBloc>(() => LoanBloc());
  locator.registerLazySingleton<QuizBloc>(() => QuizBloc());
  locator.registerLazySingleton<PrayerBloc>(() => PrayerBloc());
  locator.registerLazySingleton<TestemonyBloc>(() => TestemonyBloc());
  locator.registerSingleton<SignupReducer>(SignupReducer());
}