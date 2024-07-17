import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/auth/auth.dart';
import 'package:themovers/feature/auth/domain/usecases/email_otp_generator/email_otp_generator.dart';

final emailOtpGeneratorProvider = Provider<EmailOtpGeneratorUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailOtpGeneratorUseCase(authRepository);
});
