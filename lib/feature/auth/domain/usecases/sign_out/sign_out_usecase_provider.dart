import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(authRepository);
});
