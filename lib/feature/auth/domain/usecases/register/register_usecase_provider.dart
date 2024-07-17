import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final registerCaseProvider = Provider<RegisterUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(authRepository);
});
