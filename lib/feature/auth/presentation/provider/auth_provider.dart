import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth.dart';
import '../../domain/usecases/email_otp_checker/email_checker_usecase_provider.dart';
import '../../domain/usecases/email_otp_generator/email_otp_usecase_provider.dart';
import '../../domain/usecases/valid_email_checker/valid_email_checker_usecase_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final usecaseSignIn = ref.watch(signInUseCaseProvider);
  final usecaseSignOut = ref.watch(signOutUseCaseProvider);
  final usecaseRegister = ref.watch(registerCaseProvider);
  final usecaseforgetPasswordMobileNumberCheck =
      ref.watch(forgetPasswordMobileNumberCheckUseCase);
  final usecaseForgerPassword = ref.watch(forgetPasswordUseCaseProvider);
  final usecaseEmail = ref.watch(emailUseCaseProvider);
  final usecasePhone = ref.watch(phoneNoUseCaseProvider);
  final usecaseEmailOtpGenerator = ref.watch(emailOtpGeneratorProvider);
  final usecaseEmailOtpChecker = ref.watch(emailCheckerUseCaseProvider);
  final usecaseValidEmailChecker = ref.watch(validEmailCheckerUseCaseProvider);
  return AuthNotifier(
      usecaseSignIn,
      usecaseSignOut,
      usecaseRegister,
      usecaseforgetPasswordMobileNumberCheck,
      usecaseForgerPassword,
      usecaseEmail,
      usecasePhone,
      usecaseEmailOtpGenerator,
      usecaseEmailOtpChecker,
      usecaseValidEmailChecker);
});
