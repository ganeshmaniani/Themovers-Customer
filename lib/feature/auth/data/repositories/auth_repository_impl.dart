import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Either<Failure, AuthResult>> signIn(
      LoginEntities loginEntities) async {
    return await _authDataSource.signIn(loginEntities);
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    return await _authDataSource.register(registerEntities);
  }

  @override
  Future<Either<Failure, AuthResult>> emailChecker(String email) async {
    return await _authDataSource.emailChecker(email);
  }

  @override
  Future<Either<Failure, AuthResult>> phoneNoChecker(String phone) async {
    return await _authDataSource.phoneNoChecker(phone);
  }

  @override
  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities forgetPasswordEntities) async {
    return await _authDataSource.forgetPassword(forgetPasswordEntities);
  }

  @override
  Future<Either<Failure, AuthResult>> forgetPasswordMobileNumberChecker(
      String phone) async {
    return await _authDataSource.forgetPasswordMobileNumberChecker(phone);
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpCheckerEntities emailOtpCheckerEntities) async {
    return await _authDataSource.emailOtpChecker(emailOtpCheckerEntities);
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email) async {
    return await _authDataSource.emailOtpGenerator(email);
  }

  @override
  Future<Either<Failure, AuthResult>> validEmailChecker(String email) async {
    return await _authDataSource.validEmailChecker(email);
  }
}
