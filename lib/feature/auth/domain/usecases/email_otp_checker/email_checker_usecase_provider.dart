import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/auth_repository_provider.dart';
import 'email_otp_checker_usecase.dart';

final emailCheckerUseCaseProvider = Provider<EmailOtpCheckerUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailOtpCheckerUseCase(authRepository);
});
