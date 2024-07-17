import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/auth/domain/usecases/valid_email_checker/valid_email_checker_usecase.dart';

import '../../repositories/auth_repository_provider.dart';

final validEmailCheckerUseCaseProvider =
    Provider<ValidEmailCheckerUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ValidEmailCheckerUseCase(authRepository);
});
