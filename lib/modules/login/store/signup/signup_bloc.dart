import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/core/storage/storage.dart';
import 'package:igrejoteca_app/modules/login/store/signup/signup_event.dart';
import 'package:igrejoteca_app/modules/login/store/signup/signup_state.dart';
import 'package:igrejoteca_app/shared/data/models/auth_payload.dart';
import 'package:igrejoteca_app/shared/data/repositories/auth/auth_repository.dart';
import 'package:igrejoteca_app/shared/data/repositories/auth/auth_repository_impl.dart';
import 'package:result_dart/result_dart.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  SignupBloc() : super(SignupInitialAuthState()) {
    on<SignupDoEvent>(_signup);
  }

  Future<void> _signup(
    SignupDoEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoadingAuthState());
    Result<AuthPayload, Exception> response = await _authRepository.login(event.email, event.password);
    response.fold((success) {
      writeAccessToken(success.token);
      emit(SignupSuccessState());
    }, (failure) {
      emit(SignupErrorAuthState());
    });
  }




}