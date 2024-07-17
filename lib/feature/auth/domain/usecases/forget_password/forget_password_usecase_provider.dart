import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final forgetPasswordUseCaseProvider = Provider<ForgetPasswordUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ForgetPasswordUseCase(authRepository);
});
