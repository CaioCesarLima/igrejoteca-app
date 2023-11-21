import 'package:igrejoteca_app/shared/data/models/auth_payload.dart';
import 'package:result_dart/result_dart.dart';

abstract class AuthRepository{
  Future<Result<AuthPayload, Exception>> login(String email, String password);
  Future<Result<AuthPayload, Exception>> signup(String name, String email, String password);
  Future<Result<int, Exception>> updateScore(String userId);
}