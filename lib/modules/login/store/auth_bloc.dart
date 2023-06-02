import 'dart:async';
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/core/storage/storage.dart';
import 'package:igrejoteca_app/modules/login/store/auth_event.dart';
import 'package:igrejoteca_app/modules/login/store/auth_state.dart';
import 'package:igrejoteca_app/shared/data/models/auth_payload.dart';
import 'package:igrejoteca_app/shared/data/models/user_model.dart';
import 'package:igrejoteca_app/shared/data/repositories/auth/auth_repository.dart';
import 'package:igrejoteca_app/shared/data/repositories/auth/auth_repository_impl.dart';
import 'package:result_dart/result_dart.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  AuthBloc() : super(InitialAuthState()) {
    on<LoginEvent>(_login);
    on<SingupEvent>(_signup);
    on<CheckUserLogged>(_checkUserLogged);
    on<LogOutEvent>(_logout);
  }

  Future<void> _login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthState());
    Result<AuthPayload, Exception> response = await _authRepository.login(event.email, event.password);
    response.fold((success) {
      writeAccessToken(success.token);
      writeUserData(success.user.encodeB64());
      emit(UserLoggedState(token: success.token, user: success.user));
    }, (failure) {
      emit(ErrorAuthState());
    });
  }

  Future<void> _signup(SingupEvent event, Emitter<AuthState> emit) async {
    
  }

  Future<void> _checkUserLogged(CheckUserLogged event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    String token = await readAccessToken();
    String user = await readUserData();
    
    if(token.isEmpty){
      emit(InitialAuthState());
    }else{
      String body = utf8.decode(base64.decode(user));
      UserModel userModel = UserModel.fromJson(jsonDecode(body));
      emit(UserLoggedState(token: token, user: UserModel(email: userModel.email, id: userModel.id, name: userModel.name, scoreQuiz: userModel.scoreQuiz)));
    }
  }


  Future<void> _logout(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    await deleteAccessToken();
    await AuthRepositoryImpl().deleteFirebaseToken();
    emit(LogoutAuthState());
  }
}
