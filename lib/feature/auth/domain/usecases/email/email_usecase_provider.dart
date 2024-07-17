import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final emailUseCaseProvider = Provider<EmailUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailUseCase(authRepository);
});
