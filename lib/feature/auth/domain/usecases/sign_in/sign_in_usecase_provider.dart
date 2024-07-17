import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInUseCase(authRepository);
});
