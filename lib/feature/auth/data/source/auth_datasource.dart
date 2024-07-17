import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthResult>> signIn(LoginEntities loginEntities);

  Future<void> signOut();

  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities);

  Future<Either<Failure, AuthResult>> phoneNoChecker(String phone);

  Future<Either<Failure, AuthResult>> forgetPasswordMobileNumberChecker(
      String phone);

  Future<Either<Failure, AuthResult>> emailChecker(String email);

  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities forgetPasswordEntities);

  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email);

  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpCheckerEntities emailOtpCheckerEntities);

  Future<Either<Failure, AuthResult>> validEmailChecker(String email);
}
