import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';

import '../../auth.dart';
import '../../domain/usecases/email_otp_checker/email_otp_checker_usecase.dart';
import '../../domain/usecases/email_otp_generator/email_otp_generator_usecase.dart';
import '../../domain/usecases/valid_email_checker/valid_email_checker_usecase.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOut;
  final RegisterUseCase _registerUseCase;
  final ForgetPasswordMobileNumberCheckUseCase
      _forgetPasswordMobileNumberCheckUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final EmailUseCase _emailUseCase;
  final PhoneNoUseCase _phoneUseCase;
  final EmailOtpGeneratorUseCase _emailOtpGeneratorUseCase;
  final EmailOtpCheckerUseCase _emailOtpCheckerUseCase;
  final ValidEmailCheckerUseCase _validEmailCheckerUseCase;

  AuthNotifier(
    this._signInUseCase,
    this._signOut,
    this._registerUseCase,
    this._forgetPasswordMobileNumberCheckUseCase,
    this._forgetPasswordUseCase,
    this._emailUseCase,
    this._phoneUseCase,
    this._emailOtpGeneratorUseCase,
    this._emailOtpCheckerUseCase,
    this._validEmailCheckerUseCase,
  ) : super(const AuthState.initial());

  Future<Either<Failure, AuthResult>> signIn(
      LoginEntities loginEntities) async {
    state.copyWith(isLoading: true);
    final result = await _signInUseCase(loginEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<void> signOut() async {
    state.copyWith(isLoading: true);
    await _signOut().then((value) {
      state = state.copyWith(
        authResult: AuthResult.none,
        isLoading: false,
      );
    });
  }

  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _registerUseCase(registerEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities forgetPasswordEntities) async {
    state.copyWith(isLoading: true);
    final result = await _forgetPasswordUseCase(forgetPasswordEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> emailChecker(String email) async {
    state.copyWith(isLoading: true);
    final result = await _emailUseCase(email);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> phoneNoChecker(String phoneNo) async {
    state.copyWith(isLoading: true);
    final result = await _phoneUseCase(phoneNo);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> forgetPasswordMobileNumberChecker(
      String phoneNo) async {
    state.copyWith(isLoading: true);
    final result = await _forgetPasswordMobileNumberCheckUseCase(phoneNo);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email) async {
    state.copyWith(isLoading: true);
    final result = await _emailOtpGeneratorUseCase(email);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpCheckerEntities emailOtpCheckerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _emailOtpCheckerUseCase(emailOtpCheckerEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AuthResult>> validEmailChecker(String email) async {
    state.copyWith(isLoading: true);
    final result = await _validEmailCheckerUseCase(email);
    state.copyWith(isLoading: false);
    return result;
  }
}
