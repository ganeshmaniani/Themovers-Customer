import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final forgetPasswordMobileNumberCheckUseCase =
    Provider<ForgetPasswordMobileNumberCheckUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ForgetPasswordMobileNumberCheckUseCase(authRepository);
});
